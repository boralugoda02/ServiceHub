package com.mycompany.servicehub.service;

import com.mycompany.servicehub.dao.BookingDAO;
import com.mycompany.servicehub.model.Booking;
import java.util.List;

public class BookingService {
    private BookingDAO bookingDAO = new BookingDAO();

    public boolean isAuthorized(String userRole, String action) {
        return "admin".equals(userRole) || "customer".equals(userRole) || "worker".equals(userRole);
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