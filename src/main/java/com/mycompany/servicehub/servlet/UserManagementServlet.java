package com.mycompany.servicehub.servlet;

import com.mycompany.servicehub.dao.UserDAO;
import com.mycompany.servicehub.model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin/UserManagementServlet")
public class UserManagementServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null || !"Admin".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=UnauthorizedAccess");
            return;
        }

        String action = request.getParameter("action");
        String idStr = request.getParameter("id");
        
        if (action == null || idStr == null) {
            response.sendRedirect(request.getContextPath() + "/admin/users.jsp?error=InvalidParameters");
            return;
        }

        try {
            int userId = Integer.parseInt(idStr);
            if ("toggleStatus".equals(action)) {
                String newStatus = request.getParameter("status");
                userDAO.updateUserStatus(userId, newStatus);
                response.sendRedirect(request.getContextPath() + "/admin/users.jsp?status=success");
            } else if ("delete".equals(action)) {
                userDAO.deleteUser(userId);
                response.sendRedirect(request.getContextPath() + "/admin/users.jsp?status=deleted");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/users.jsp?error=InvalidAction");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/users.jsp?error=ProcessingError");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
