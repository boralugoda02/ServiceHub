package com.mycompany.servicehub.servlet;

import com.mycompany.servicehub.dao.UserDAO;
import com.mycompany.servicehub.dao.AuditLogDAO;
import com.mycompany.servicehub.model.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/change-password")
public class ChangePasswordServlet extends BaseServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp?error=SessionExpired");
            return;
        }

        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        UserDAO dao = new UserDAO();

        try {
            // Verify if the old password is correct and if new passwords match
            if (dao.checkPassword(user.getUserId(), oldPassword) && newPassword.equals(confirmPassword)) {
                // Hash the new password before storing it
                String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
                dao.updatePassword(user.getEmail(), hashedPassword);

                // Log this activity
                logActivity(user.getUserId(), "PASSWORD_CHANGED", request);

                response.sendRedirect("profile.jsp?status=PasswordChanged");
            } else {
                // Redirect back if validation fails
                response.sendRedirect("profile.jsp?error=InvalidPassword");
            }
        } catch (Exception e) {
            response.sendRedirect("profile.jsp?error=Error");
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