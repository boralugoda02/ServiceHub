package com.mycompany.servicehub.servlet;

import com.mycompany.servicehub.model.Booking;
import com.mycompany.servicehub.model.ServiceRequest;
import com.mycompany.servicehub.dao.ServiceRequestDAO;
import com.mycompany.servicehub.dao.CategoryDAO;
import com.mycompany.servicehub.dao.BookingDAO;
import com.mycompany.servicehub.service.BookingService;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {
    private BookingService bookingService = new BookingService();
    private BookingDAO bookingDAO = new BookingDAO();
    private ServiceRequestDAO serviceRequestDAO = new ServiceRequestDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            try {
                int bookingId = Integer.parseInt(request.getParameter("id"));
                bookingDAO.deleteBooking(bookingId);
                response.sendRedirect("admin/bookings.jsp?status=deleted");
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("admin/bookings.jsp?error=DeleteFailed");
            }
        } else {
            response.sendRedirect("index.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        com.mycompany.servicehub.model.User user = (session != null) ? (com.mycompany.servicehub.model.User) session.getAttribute("user") : null;
        String userType = (user != null && user.getRole() != null) ? user.getRole().toLowerCase() : null;
        String action = request.getParameter("action");

        // Verify authorization
        if (!bookingService.isAuthorized(userType, action)) {
            response.sendRedirect("error.jsp?error=UnauthorizedAccess");
            return;
        }

        try {
            if ("createRequest".equals(action)) {
                Integer customerId = (Integer) session.getAttribute("customerId");
                if (customerId == null) {
                    response.sendRedirect("login.jsp?error=LoginRequired");
                    return;
                }
                String district = request.getParameter("district");
                String city = request.getParameter("city");
                String address = request.getParameter("address");
                String serviceDate = request.getParameter("serviceDate");
                String serviceTime = request.getParameter("serviceTime");

                // 1. Create a service request first
                ServiceRequest sr = new ServiceRequest();
                sr.setCustomerId(customerId);
                sr.setCategoryId(categoryDAO.getOrCreateDefaultCategoryId());
                sr.setTitle("Service Request at " + city);
                sr.setDescription("Address: " + address + ", District: " + district);
                sr.setLocation(city);
                sr.setStatus("Pending");

                int requestId = serviceRequestDAO.saveRequestAndGetId(sr);
                if (requestId == -1) {
                    response.sendRedirect("customer/request-service.jsp?error=DatabaseError");
                    return;
                }

                // 2. Create the booking referencing the request
                Booking b = new Booking();
                b.setCustomerId(customerId);
                b.setRequestId(requestId);
                b.setServiceDate(serviceDate);
                b.setServiceTime(serviceTime);
                b.setBookingStatus("Pending");
                b.setPaymentStatus("Pending");
                b.setTotalAmount(0.0);
                b.setNotes("Address: " + address + ", District: " + district);

                if (bookingService.processBooking(b)) {
                    response.sendRedirect("customer/my-bookings.jsp?status=success");
                } else {
                    response.sendRedirect("customer/request-service.jsp?error=DatabaseError");
                }

            } else if ("confirm".equals(action)) {
                int bookingId = Integer.parseInt(request.getParameter("bookingId"));
                bookingDAO.updateBookingStatus(bookingId, "Confirmed");
                response.sendRedirect("customer/my-bookings.jsp?status=confirmed");

            } else if ("cancel".equals(action)) {
                int bookingId = Integer.parseInt(request.getParameter("bookingId"));
                bookingDAO.updateBookingStatus(bookingId, "Cancelled");
                response.sendRedirect("customer/my-bookings.jsp?status=cancelled");

            } else if ("accept".equals(action)) {
                int bookingId = Integer.parseInt(request.getParameter("bookingId"));
                bookingDAO.updateBookingStatus(bookingId, "Accepted");
                response.sendRedirect("worker/my-jobs.jsp?status=accepted");

            } else if ("reject".equals(action)) {
                int bookingId = Integer.parseInt(request.getParameter("bookingId"));
                bookingDAO.updateBookingStatus(bookingId, "Rejected");
                response.sendRedirect("worker/my-jobs.jsp?status=rejected");

            } else if ("start".equals(action)) {
                int bookingId = Integer.parseInt(request.getParameter("bookingId"));
                bookingDAO.updateBookingStatus(bookingId, "In Progress");
                response.sendRedirect("worker/my-jobs.jsp?status=started");

            } else if ("complete".equals(action)) {
                int bookingId = Integer.parseInt(request.getParameter("bookingId"));
                bookingDAO.updateBookingStatus(bookingId, "Completed");
                response.sendRedirect("worker/my-jobs.jsp?status=completed");

            } else if ("update".equals(action)) {
                int bookingId = Integer.parseInt(request.getParameter("id"));
                String status = request.getParameter("status");
                bookingDAO.updateBookingStatus(bookingId, status);
                response.sendRedirect("admin/bookings.jsp?status=updated");

            } else {
                response.sendRedirect("index.jsp?error=InvalidAction");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?error=ProcessingError");
        }
    }
}