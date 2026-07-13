package com.mycompany.servicehub.servlet;

import com.mycompany.servicehub.dao.NotificationDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/NotificationServlet")
public class NotificationServlet extends HttpServlet {
    private NotificationDAO notificationDAO = new NotificationDAO();

    // Handle incoming actions
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        com.mycompany.servicehub.model.User user = (com.mycompany.servicehub.model.User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = user.getUserId();
        String action = request.getParameter("action"); // "VIEW", "MARK_READ", "DELETE"

        if ("MARK_READ".equals(action)) {
            int nId = Integer.parseInt(request.getParameter("id"));
            notificationDAO.markAsRead(nId);
            response.sendRedirect("notifications.jsp");
            
        } else if ("DELETE".equals(action)) {
            int nId = Integer.parseInt(request.getParameter("id"));
            notificationDAO.deleteNotification(nId);
            response.sendRedirect("notifications.jsp");
            
        } else {
            // Default: View all notifications for the user
            request.setAttribute("notifications", notificationDAO.getNotifications(userId));
            request.getRequestDispatcher("notifications.jsp").forward(request, response);
        }
    }
}