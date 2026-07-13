package com.mycompany.servicehub.servlet;

import com.mycompany.servicehub.dao.UserDAO;
import com.mycompany.servicehub.dao.AuditLogDAO;
import com.mycompany.servicehub.model.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends BaseServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Get the email address submitted by the user
        String email = request.getParameter("email");
        UserDAO dao = new UserDAO();

        try {
            // Check if the user exists in the database with the provided email
            User existingUser = dao.getUserByEmail(email);
            if (existingUser != null) {
                logActivity(existingUser.getUserId(), "FORGOT_PASSWORD_REQUEST", request);
                // If user exists, redirect to reset password page with email as a parameter
                response.sendRedirect("reset-password.jsp?email=" + email);
            } else {
                // If user not found, redirect back to login page with an error message
                response.sendRedirect("forgot-password.jsp?error=UserNotFound");
            }
        } catch (Exception e) {
            // Handle any database or processing errors
            response.sendRedirect("forgot-password.jsp?error=Error");
        }
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