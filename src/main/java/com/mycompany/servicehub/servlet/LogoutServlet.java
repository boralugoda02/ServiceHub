package com.mycompany.servicehub.servlet;

import com.mycompany.servicehub.dao.AuditLogDAO;
import com.mycompany.servicehub.model.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet({"/logout", "/LogoutServlet"})
public class LogoutServlet extends BaseServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

        // 1. Get the current session
        HttpSession session = request.getSession(false);

        // 2. Log the logout event BEFORE destroying the session
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user != null) {
                logActivity(user.getUserId(), "User logged out", request);
            }
            session.invalidate();
        }

        // 3. Redirect to login page
        response.sendRedirect("login.jsp?message=loggedout");
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