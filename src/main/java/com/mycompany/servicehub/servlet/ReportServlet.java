package com.mycompany.servicehub.servlet;

import com.mycompany.servicehub.dao.BookingDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/ReportServlet")
public class ReportServlet extends HttpServlet {
    private BookingDAO dao = new BookingDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        com.mycompany.servicehub.model.User user = (com.mycompany.servicehub.model.User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        String userType = user.getRole() != null ? user.getRole().toUpperCase() : "";
        int userId = user.getUserId();

        // Logic to fetch reports based on user role
        if ("ADMIN".equals(userType)) {
            request.setAttribute("total", dao.getBookingCountByStatus("All"));
            request.setAttribute("active", dao.getBookingCountByStatus("Pending"));
            request.setAttribute("cancelled", dao.getBookingCountByStatus("Cancelled"));
        } else if ("CUSTOMER".equals(userType)) {
            request.setAttribute("history", dao.getCustomerHistory(userId));
        } else if ("WORKER".equals(userType)) {
            request.setAttribute("completed", dao.getWorkerCompletedJobs(userId));
        }
        
        request.getRequestDispatcher("reports.jsp").forward(request, response);
    }
}