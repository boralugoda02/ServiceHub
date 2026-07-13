package com.mycompany.servicehub.servlet;

import com.mycompany.servicehub.dao.AuditLogDAO;
import com.mycompany.servicehub.model.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/createJobRequest")
public class JobRequestServlet extends BaseServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String customerIdStr = request.getParameter("customerId");

        // Logic to save job request using JobRequestService
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user != null) {
            logActivity(user.getUserId(), "Created job request", request);
        }

        response.sendRedirect("my-requests.jsp");
    }

    private void sendError(HttpServletResponse res, String page, String error) throws IOException {
        res.sendRedirect(page + "?error=" + error);
    }

    // Helper method to log activity
    private void logActivity(int userId, String action, HttpServletRequest request) {
        String ipAddress = request.getRemoteAddr();
        AuditLogDAO logDAO = new AuditLogDAO();
        logDAO.insertLog(userId, action, ipAddress);
    }
}