package com.mycompany.servicehub.servlet;

import com.mycompany.servicehub.dao.ServiceRequestDAO;
import com.mycompany.servicehub.model.ServiceRequest;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;

@WebServlet("/UploadServiceImageServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 10)
public class UploadServiceImageServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Get and Validate Budget & Contact
        String budgetStr = request.getParameter("budget");
        String contact = request.getParameter("contact");

        try {
            int budget = Integer.parseInt(budgetStr);
            if (budget < 500) {
                response.sendRedirect("customer/request-service.jsp?error=InvalidBudget");
                return;
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("customer/request-service.jsp?error=InvalidBudget");
            return;
        }

        if (contact == null || !contact.matches("\\d{10}")) {
            response.sendRedirect("customer/request-service.jsp?error=InvalidContact");
            return;
        }

        // 2. Retrieve customer ID from session (resolves hardcoded ID = 1)
        HttpSession session = request.getSession(false);
        com.mycompany.servicehub.model.User user = (session != null) ? (com.mycompany.servicehub.model.User) session.getAttribute("user") : null;
        if (user == null || !"Customer".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect("login.jsp?error=LoginRequired");
            return;
        }
        int customerId = user.getUserId();

        // 3. Handle File Upload with Path Traversal Protection and unique naming
        Part filePart = request.getPart("serviceImage");
        String rawFileName = java.nio.file.Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        
        String extension = "";
        int i = rawFileName.lastIndexOf('.');
        if (i > 0) {
            extension = rawFileName.substring(i).toLowerCase();
        }
        
        // Prevent collision and reserved characters
        String fileName = "req_" + customerId + "_" + System.currentTimeMillis() + extension;
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();
        filePart.write(uploadPath + File.separator + fileName);

        // 4. Save to Database
        ServiceRequest sr = new ServiceRequest();
        sr.setCustomerId(customerId);
        sr.setTitle(request.getParameter("title"));
        sr.setDescription(request.getParameter("description"));
        sr.setStatus("Pending");
        sr.setImagePath("uploads/" + fileName); 

        ServiceRequestDAO dao = new ServiceRequestDAO();
        if (dao.saveRequest(sr)) {
            response.sendRedirect("customer/my-requests.jsp?success=Posted");
        } else {
            response.sendRedirect("customer/request-service.jsp?error=DatabaseError");
        }
    }
}