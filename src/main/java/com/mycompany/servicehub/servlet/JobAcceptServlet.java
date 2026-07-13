package com.mycompany.servicehub.servlet;

import com.mycompany.servicehub.dao.ServiceDAO;
import com.mycompany.servicehub.model.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/acceptJob")
public class JobAcceptServlet extends BaseServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        User worker = (User) session.getAttribute("user");

        // Verify if worker is logged in and has the right role
        if (worker == null || !"Worker".equals(worker.getRole())) {
            response.sendRedirect("login.jsp?error=Unauthorized");
            return;
        }

        String requestIdStr = request.getParameter("requestId");
        if (requestIdStr != null) {
            try {
                int requestId = Integer.parseInt(requestIdStr);
                ServiceDAO serviceDAO = new ServiceDAO();

                // Update job status to 'Accepted' (requestId first, workerId second)
                boolean success = serviceDAO.acceptJob(requestId, worker.getUserId());

                if (success) {
                    response.sendRedirect("worker/my-jobs.jsp?status=Accepted");
                } else {
                    // Happens if someone else already took the job
                    response.sendRedirect("worker/find-jobs.jsp?error=AlreadyTaken");
                }
            } catch (Exception e) {
                response.sendRedirect("worker/find-jobs.jsp?error=SystemError");
            }
        }
    }
}