package com.mycompany.servicehub.servlet;

import com.mycompany.servicehub.dao.JobApplicationDAO;
import com.mycompany.servicehub.dao.ServiceRequestDAO;
import com.mycompany.servicehub.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/JobApplicationServlet")
public class JobApplicationServlet extends BaseServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Ensure user is logged in
        if (!checkAuth(request, response)) return;

        // Get request ID and current user ID
        int requestId = Integer.parseInt(request.getParameter("requestId"));
        User worker = (User) request.getSession().getAttribute("user");

        // DAO objects for operations
        JobApplicationDAO appDAO = new JobApplicationDAO();
        ServiceRequestDAO reqDAO = new ServiceRequestDAO();

        // 1. Save application to job_applications table
        boolean isApplied = appDAO.applyForJob(requestId, worker.getUserId());

        // 2. Update service request status to 'Accepted'
        boolean isUpdated = reqDAO.updateStatus(requestId, "Accepted");

        if (isApplied && isUpdated) {
            // Success: Redirect to worker's job list
            response.sendRedirect("worker/my-jobs.jsp?status=Success");
        } else {
            // Error: Redirect to find-jobs with error message
            response.sendRedirect("worker/find-jobs.jsp?error=FailedToAccept");
        }
    }
}