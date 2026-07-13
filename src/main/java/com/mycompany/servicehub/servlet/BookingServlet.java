package com.mycompany.servicehub.servlet;

import com.mycompany.servicehub.model.Booking;
import com.mycompany.servicehub.service.BookingService;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {
    private BookingService bookingService = new BookingService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        com.mycompany.servicehub.model.User user = (session != null) ? (com.mycompany.servicehub.model.User) session.getAttribute("user") : null;
        String userType = (user != null && user.getRole() != null) ? user.getRole().toLowerCase() : null;
        String action = request.getParameter("action"); // e.g., "CREATE"

        // Verify authorization using the Service class
        if (bookingService.isAuthorized(userType, action)) {
            
            // Logic to process the booking if authorized
            Booking b = new Booking();
            // ... (Set your booking fields here) ...
            
            if (bookingService.processBooking(b)) {
                response.sendRedirect("success.jsp");
            } else {
                response.sendRedirect("request-service.jsp?error=DatabaseError");
            }
            
        } else {
            // Redirect to unauthorized error page if access is denied
            response.sendRedirect("unauthorized.jsp?error=AccessDenied");
        }
    }
}