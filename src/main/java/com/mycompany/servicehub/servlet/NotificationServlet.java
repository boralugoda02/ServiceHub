package com.mycompany.servicehub.servlet;

import com.mycompany.servicehub.dao.NotificationDAO;
import com.mycompany.servicehub.model.User;
import com.mycompany.servicehub.util.NotificationUtil;
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
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        int userId = user.getUserId();
        String action = request.getParameter("action");

        String redirectPath = "customer/notifications.jsp";
        if ("Admin".equalsIgnoreCase(user.getRole())) {
            redirectPath = "admin/notifications.jsp";
        }

        if ("MARK_READ".equalsIgnoreCase(action)) {
            int nId = Integer.parseInt(request.getParameter("id"));
            notificationDAO.markAsRead(nId);
            response.sendRedirect(request.getContextPath() + "/" + redirectPath);
            
        } else if ("DELETE".equalsIgnoreCase(action)) {
            int nId = Integer.parseInt(request.getParameter("id"));
            notificationDAO.deleteNotification(nId);
            response.sendRedirect(request.getContextPath() + "/" + redirectPath);
            
        } else {
            // Default: View all notifications for the user
            request.setAttribute("notifications", notificationDAO.getNotifications(userId));
            request.getRequestDispatcher(redirectPath).forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !"Admin".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if ("broadcast".equalsIgnoreCase(action)) {
            String message = request.getParameter("message");
            if (message != null && !message.trim().isEmpty()) {
                NotificationUtil.send(
                    0, // System/Admin sender ID
                    0, // Broadcast recipient ID
                    "System Announcement",
                    message,
                    "BROADCAST"
                );
            }
            response.sendRedirect(request.getContextPath() + "/admin/notifications.jsp");
        }
    }
}