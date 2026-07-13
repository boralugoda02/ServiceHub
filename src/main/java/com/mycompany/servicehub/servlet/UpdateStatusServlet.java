package com.mycompany.servicehub.servlet;

import com.mycompany.servicehub.dao.UserDAO;
import com.mycompany.servicehub.model.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

/**
 * Servlet to handle the worker status update functionality.
 */
@WebServlet("/UpdateStatusServlet")
public class UpdateStatusServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Retrieve the new status from the form
        String newStatus = request.getParameter("status");

        // Retrieve the logged-in user from the session
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user != null && newStatus != null) {
            int userId = user.getUserId();

            // Initialize DAO and update the status in the database
            UserDAO userDAO = new UserDAO();
            boolean isUpdated = userDAO.updateStatus(userId, newStatus);

            if (isUpdated) {
                // Update session attribute and User object to reflect the change in the UI
                user.setAvailabilityStatus(newStatus);
                user.setStatus(newStatus);
                session.setAttribute("user", user);
                session.setAttribute("userStatus", newStatus);
                // Redirect back to dashboard with a success message
                response.sendRedirect("worker/dashboard.jsp?msg=StatusUpdated");
            } else {
                // Handle update failure
                response.sendRedirect("worker/dashboard.jsp?msg=UpdateFailed");
            }
        } else {
            // Handle unauthorized access or missing session
            response.sendRedirect("login.jsp");
        }
    }
}