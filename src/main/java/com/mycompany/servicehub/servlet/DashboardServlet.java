package com.mycompany.servicehub.servlet;

import com.mycompany.servicehub.dao.AdminDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

/**
 * Servlet to fetch statistics for the Admin Dashboard.
 */
@WebServlet("/admin/DashboardServlet")
public class DashboardServlet extends HttpServlet {

    // Initialize DAO instance
    private AdminDAO dao = new AdminDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Ensure only authorized admins can access the dashboard
        HttpSession session = request.getSession();
        com.mycompany.servicehub.model.User user = (com.mycompany.servicehub.model.User) session.getAttribute("user");
        
        if (user == null || !"Admin".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Fetch statistics from the database using AdminDAO
        // Total count statistics
        request.setAttribute("totalUsers", dao.getCount("users"));
        request.setAttribute("totalRequests", dao.getCount("service_requests"));
        request.setAttribute("totalReviews", dao.getCount("reviews"));
        
        // Specific status statistics
        request.setAttribute("activeBookings", dao.getActiveBookingsCount());
        request.setAttribute("completedJobs", dao.getCompletedJobsCount());
        request.setAttribute("pendingRequests", dao.getPendingRequestsCount());
        
        // Forward the gathered data to the dashboard JSP (using context-relative absolute path)
        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
}