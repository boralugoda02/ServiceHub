package com.mycompany.servicehub.service;

import com.mycompany.servicehub.dao.BookingDAO;
import com.mycompany.servicehub.model.Booking;
import java.util.List;

public class BookingService {
    private BookingDAO bookingDAO = new BookingDAO();

    public boolean isAuthorized(String userRole, String action) {
        if (userRole == null || action == null) return false;
        
        switch (action) {
            case "delete":
            case "update":
                return "admin".equalsIgnoreCase(userRole);
                
            case "createRequest":
            case "confirm":
            case "cancel":
                return "customer".equalsIgnoreCase(userRole) || "admin".equalsIgnoreCase(userRole);
                
            case "accept":
            case "reject":
            case "start":
            case "complete":
                return "worker".equalsIgnoreCase(userRole) || "admin".equalsIgnoreCase(userRole);
                
            default:
                return false;
        }
    }

    public boolean isValidTransition(String currentStatus, String targetStatus) {
        if (currentStatus == null || targetStatus == null) return false;
        
        switch (targetStatus) {
            case "Pending":
                return false; // cannot go back to pending once created
            case "Confirmed":
                return "Pending".equalsIgnoreCase(currentStatus);
            case "Cancelled":
                return "Pending".equalsIgnoreCase(currentStatus) || "Confirmed".equalsIgnoreCase(currentStatus);
            case "Accepted":
                return "Pending".equalsIgnoreCase(currentStatus) || "Confirmed".equalsIgnoreCase(currentStatus);
            case "Rejected":
                return "Pending".equalsIgnoreCase(currentStatus) || "Confirmed".equalsIgnoreCase(currentStatus);
            case "In Progress":
                return "Accepted".equalsIgnoreCase(currentStatus) || "Confirmed".equalsIgnoreCase(currentStatus);
            case "Completed":
                return "In Progress".equalsIgnoreCase(currentStatus);
            default:
                return false;
        }
    }

    public boolean processBooking(Booking booking) {
        // නව Schema එකට අනුව IDs වලංගුකරණය (Validate) කිරීම
        if (booking.getCustomerId() == null || booking.getRequestId() == null) {
            return false;
        }
        return bookingDAO.createBooking(booking);
    }

    public List<Booking> getCustomerBookings(int customerId) {
        return bookingDAO.getCustomerHistory(customerId);
    }
    public Booking getBookingDetails(int bookingId) {
        return bookingDAO.getBookingById(bookingId);
    }
    public List<Booking> getJobsByWorker(int workerId) {
        return bookingDAO.getJobsByWorker(workerId);
    }
}