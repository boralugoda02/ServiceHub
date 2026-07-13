package com.mycompany.servicehub.servlet;

import com.mycompany.servicehub.dao.UserDAO;
import com.mycompany.servicehub.util.NotificationUtil;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/ServiceRequestServlet")
public class ServiceRequestServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Get request details from the form
        String serviceType = request.getParameter("serviceType");
        String customerCity = request.getParameter("city");
        
        // --- මෙහිදී ඔබ ඔබේ Booking එක Database එකට Save කරන Logic එක ලියන්න ---
        // BookingDAO bookingDAO = new BookingDAO();
        // bookingDAO.createBooking(...);

        // 2. Identify nearby workers for the given city
        List<Integer> nearbyWorkers = userDAO.getNearbyWorkers(customerCity);

        // 3. Notify each worker
        if (nearbyWorkers != null && !nearbyWorkers.isEmpty()) {
            for (int workerId : nearbyWorkers) {
                NotificationUtil.send(
                    0, // 0 = System Administrator ID
                    workerId, 
                    "New Job Available!", 
                    "A new " + serviceType + " job is now available in " + customerCity + ". Check your dashboard!", 
                    "NEW_JOB"
                );
            }
        }

        // 4. Redirect to success page
        response.sendRedirect("customer/dashboard.jsp?status=success");
    }
}