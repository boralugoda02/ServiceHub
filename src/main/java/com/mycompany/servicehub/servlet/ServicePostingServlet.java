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
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp?error=Unauthorized");
            return;
        }

        String title = request.getParameter("title");
        String category = request.getParameter("category");
        String budgetStr = request.getParameter("budget");

        if (title == null || category == null || budgetStr == null) {
            response.sendRedirect("customer/request-service.jsp?error=EmptyFields");
            return;
        }

        try {
            double budget = Double.parseDouble(budgetStr);
            ServiceDAO serviceDAO = new ServiceDAO();

            boolean success = serviceDAO.saveRequest(user.getUserId(), title, category, budget, "Pending");
            if (success) {
                // Log the service posting event
                logActivity(user.getUserId(), "Posted new service request: " + title, request);

                response.sendRedirect("customer/my-bookings.jsp?status=Posted");
            } else {
                response.sendRedirect("customer/request-service.jsp?error=DatabaseError");
            }
        } catch (Exception e) {
            response.sendRedirect("customer/request-service.jsp?error=InvalidBudget");
        }
    }

    // Helper method to log activity
    private void logActivity(int userId, String action, HttpServletRequest request) {
        String ipAddress = request.getRemoteAddr();
        AuditLogDAO logDAO = new AuditLogDAO();
        logDAO.insertLog(userId, action, ipAddress);
    }
}