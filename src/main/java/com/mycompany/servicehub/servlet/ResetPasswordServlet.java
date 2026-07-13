package com.mycompany.servicehub.servlet;

import com.mycompany.servicehub.dao.UserDAO;
import com.mycompany.servicehub.dao.AuditLogDAO;
import com.mycompany.servicehub.model.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/reset-password")
public class ResetPasswordServlet extends BaseServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");

        String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());

        UserDAO dao = new UserDAO();
        try {
            dao.updatePassword(email, hashedPassword);

            // Log the password reset event
            User user = dao.getUserByEmail(email);
            if (user != null) {
                logActivity(user.getUserId(), "Password reset", request);
            }

            response.sendRedirect("login.jsp?status=PasswordChanged");
        } catch (Exception e) {
            response.sendRedirect("reset-password.jsp?email=" + email + "&error=UpdateFailed");
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