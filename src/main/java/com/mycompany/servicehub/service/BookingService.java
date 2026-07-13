package com.mycompany.servicehub.service;

import com.mycompany.servicehub.dao.BookingDAO;
import com.mycompany.servicehub.model.Booking;

public class BookingService {
    private BookingDAO bookingDAO = new BookingDAO();

    public boolean isAuthorized(String userRole, String action) {
        // Admin or Customer can perform bookings
        return "admin".equals(userRole) || "customer".equals(userRole);
    }

    public boolean processBooking(Booking booking) {
        if (booking.getCustomerName() == null || booking.getServiceName() == null) {
            return false;
        }
        return bookingDAO.createBooking(booking);
    }
}