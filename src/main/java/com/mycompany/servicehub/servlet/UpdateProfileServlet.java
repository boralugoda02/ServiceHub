package com.mycompany.servicehub.servlet;

import com.mycompany.servicehub.dao.ServiceRequestDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/UpdateJobStatusServlet")
public class UpdateProfileServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Read parameters from the request URL
        String idParam = request.getParameter("id");
        String newStatus = request.getParameter("status"); // e.g., "Completed", "In Progress"

        if (idParam == null || newStatus == null) {
            response.sendRedirect("worker/my-jobs.jsp?error=InvalidRequest");
            return;
        }

        int requestId = Integer.parseInt(idParam);
        
        // Update the status in the database using DAO
        ServiceRequestDAO dao = new ServiceRequestDAO();
        boolean isUpdated = dao.updateStatus(requestId, newStatus);

        if (isUpdated) {
            // Success: Redirect back to the worker's job list
            response.sendRedirect("worker/my-jobs.jsp?success=StatusUpdated");
        } else {
            // Error: Redirect with failure message
            response.sendRedirect("worker/my-jobs.jsp?error=UpdateFailed");
        }
    }
}