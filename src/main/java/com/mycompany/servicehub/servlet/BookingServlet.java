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
        HttpSession session = request.getSession(false);
        com.mycompany.servicehub.model.User user = (session != null) ? (com.mycompany.servicehub.model.User) session.getAttribute("user") : null;
        String userRole = (user != null && user.getRole() != null) ? user.getRole().toLowerCase() : null;
        String action = request.getParameter("action");
        
        if ("delete".equals(action)) {
            if (!"admin".equals(userRole)) {
                response.sendRedirect("error.jsp?error=UnauthorizedAccess");
                return;
            }
            try {
                int bookingId = Integer.parseInt(request.getParameter("id"));
                bookingDAO.deleteBooking(bookingId);
                response.sendRedirect("admin/bookings.jsp?status=deleted");
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("admin/bookings.jsp?error=DeleteFailed");
            }
        } else {
            Integer customerId = (Integer) session.getAttribute("customerId");
            if (customerId != null && "customer".equals(userRole)) {
                try {
                    // 💡 ServiceRequestDAO වෙනුවට BookingDAO එක භාවිතයෙන් Bookings ලැයිස්තුව ලබා ගැනීම
                    // (ඔයාගේ BookingDAO එකේ customerId එකෙන් bookings ගන්න මෙතඩ් එකක් ඇති, එය මෙතැනට යොදන්න)
                    java.util.List<com.mycompany.servicehub.model.Booking> bookingList = bookingDAO.getBookingsByCustomerId(customerId);
                    
                    request.setAttribute("bookings", bookingList);
                    request.getRequestDispatcher("customer/my-bookings.jsp").forward(request, response);
                    return;
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
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

                // Future date validation logic
                try {
                    java.time.LocalDate today = java.time.LocalDate.now();
                    java.time.LocalDate requestedDate = java.time.LocalDate.parse(serviceDate);
                    if (requestedDate.isBefore(today)) {
                        response.sendRedirect("customer/request-service.jsp?error=InvalidDate");
                        return;
                    }
                } catch (Exception e) {
                    response.sendRedirect("customer/request-service.jsp?error=InvalidDateFormat");
                    return;
                }

                // 1. Create a service request first
                //  මෙසේ වෙනස් කරන්න:
ServiceRequest sr = new ServiceRequest();
sr.setCustomerId(customerId);
sr.setCategoryId(categoryDAO.getOrCreateDefaultCategoryId());
sr.setTitle("Service Request at " + city);
sr.setDescription("Address: " + address + ", District: " + district);
sr.setLocation(city);
sr.setStatus("Pending");
// 💡 ඩේටාබේස් එකේ field එක decimal(10,2) නිසා budget එකක් සෙට් කරන්න


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
    // කෙලින්ම JSP එකට නොයා දත්ත Load කරන Servlet එකටම යොමු කිරීම (Relative Path එකක් ලෙස)
    response.sendRedirect("BookingServlet?status=success");
} else {
                    response.sendRedirect("customer/request-service.jsp?error=DatabaseError");
                }

            } else if ("confirm".equals(action) || "cancel".equals(action) || "accept".equals(action) || 
                       "reject".equals(action) || "start".equals(action) || "complete".equals(action) || "update".equals(action)) {
                
                int bookingId;
                String targetStatus = "";
                String redirectUrl = "";
                
                if ("update".equals(action)) {
                    bookingId = Integer.parseInt(request.getParameter("id"));
                    targetStatus = request.getParameter("status");
                    redirectUrl = "admin/bookings.jsp?status=updated";
                } else {
                    bookingId = Integer.parseInt(request.getParameter("bookingId"));
                    if ("confirm".equals(action)) { targetStatus = "Confirmed"; redirectUrl = "customer/my-bookings.jsp?status=confirmed"; }
                    else if ("cancel".equals(action)) { targetStatus = "Cancelled"; redirectUrl = "customer/my-bookings.jsp?status=cancelled"; }
                    else if ("accept".equals(action)) { targetStatus = "Accepted"; redirectUrl = "worker/my-jobs.jsp?status=accepted"; }
                    else if ("reject".equals(action)) { targetStatus = "Rejected"; redirectUrl = "worker/my-jobs.jsp?status=rejected"; }
                    else if ("start".equals(action)) { targetStatus = "In Progress"; redirectUrl = "worker/my-jobs.jsp?status=started"; }
                    else if ("complete".equals(action)) { targetStatus = "Completed"; redirectUrl = "worker/my-jobs.jsp?status=completed"; }
                }

                Booking booking = bookingDAO.getBookingById(bookingId);
                if (booking == null) {
                    response.sendRedirect("error.jsp?error=BookingNotFound");
                    return;
                }

                // If not Admin, enforce strict state machine transitions
                if (!"admin".equals(userType)) {
                    if (!bookingService.isValidTransition(booking.getBookingStatus(), targetStatus)) {
                        response.sendRedirect("error.jsp?error=InvalidStateTransition");
                        return;
                    }
                }

                bookingDAO.updateBookingStatus(bookingId, targetStatus);
                response.sendRedirect(redirectUrl);

            } else {
                response.sendRedirect("index.jsp?error=InvalidAction");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?error=ProcessingError");
        }
    }
}