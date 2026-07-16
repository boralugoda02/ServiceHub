package com.mycompany.servicehub.servlet;

import com.mycompany.servicehub.dao.ServiceDAO;
import com.mycompany.servicehub.dao.AuditLogDAO;
import com.mycompany.servicehub.model.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/postService")
public class ServicePostingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
    HttpSession session = request.getSession();
    
    // JSP එකේ ඇති සැබෑ Session attribute එක වන "customerId" ලබාගනිමු
    Integer customerId = (Integer) session.getAttribute("customerId");

    if (customerId == null) {
        response.sendRedirect("login.jsp?error=Unauthorized");
        return;
    }

    String district = request.getParameter("district");
    String city = request.getParameter("city");
    String fullAddress = request.getParameter("fullAddress"); 
    String serviceDate = request.getParameter("serviceDate");
    String serviceTime = request.getParameter("serviceTime");

    if (city == null || city.isEmpty()) {
        response.sendRedirect("customer/request-service.jsp?error=EmptyFields");
        return;
    }

    try {
        String dynamicTitle = "Need Service at " + city + " (" + district + ")";
        String detailsSummary = "Address: " + fullAddress + " | Date: " + serviceDate + " | Time: " + serviceTime;
        double defaultBudget = 1.0; // 0.0 වෙනුවට 1.0 ලෙස ආරක්ෂිත අගයක් දෙමු
        String status = "Pending";

        ServiceDAO serviceDAO = new ServiceDAO();
        // ලබාගත් customerId එක ඍජුවම මෙතැනට පාස් කරමු
        boolean success = serviceDAO.saveRequest(customerId, dynamicTitle, detailsSummary, defaultBudget, status, city);
        
        if (success) {
            response.sendRedirect("customer/my-bookings.jsp?status=Posted");
        } else {
            response.sendRedirect("customer/request-service.jsp?error=DatabaseError");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("customer/request-service.jsp?error=DatabaseError");
    }
}

    // Helper method to log activity
    private void logActivity(int userId, String action, HttpServletRequest request) {
        String ipAddress = request.getRemoteAddr();
        AuditLogDAO logDAO = new AuditLogDAO();
        logDAO.insertLog(userId, action, ipAddress);
    }
}