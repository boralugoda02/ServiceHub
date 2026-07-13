package com.mycompany.servicehub.dao;

import com.mycompany.servicehub.model.Booking;
import com.mycompany.servicehub.config.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {
    
    private Connection getConnection() throws SQLException {
        return DBConnection.getConnection();
    }

    public boolean createBooking(Booking b) {
        String sql = "INSERT INTO bookings (request_id, customer_id, worker_id, service_date, service_time, booking_status, payment_status, total_amount, notes) VALUES (?,?,?,?,?,?,?,?,?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            if (b.getRequestId() != null) ps.setInt(1, b.getRequestId()); else ps.setNull(1, Types.INTEGER);
            if (b.getCustomerId() != null) ps.setInt(2, b.getCustomerId()); else ps.setNull(2, Types.INTEGER);
            if (b.getWorkerId() != null) ps.setInt(3, b.getWorkerId()); else ps.setNull(3, Types.INTEGER);
            ps.setString(4, b.getServiceDate());
            ps.setString(5, b.getServiceTime());
            ps.setString(6, b.getBookingStatus() != null ? b.getBookingStatus() : "Confirmed");
            ps.setString(7, b.getPaymentStatus() != null ? b.getPaymentStatus() : "Pending");
            ps.setDouble(8, b.getTotalAmount());
            ps.setString(9, b.getNotes());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public List<Booking> getAllBookings() {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT * FROM bookings";
        try (Connection conn = getConnection(); Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public void updateBookingStatus(int bookingId, String status) {
        String sql = "UPDATE bookings SET booking_status = ? WHERE booking_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, bookingId);
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public void deleteBooking(int bookingId) {
        String sql = "DELETE FROM bookings WHERE booking_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public int getBookingCountByStatus(String status) {
        String sql = "SELECT COUNT(*) FROM bookings WHERE booking_status = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    public List<Booking> getCustomerHistory(int customerId) {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT * FROM bookings WHERE customer_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public int getWorkerCompletedJobs(int workerId) {
        String sql = "SELECT COUNT(*) FROM bookings WHERE worker_id = ? AND booking_status = 'Completed'";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, workerId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    public Booking getBookingById(int bookingId) {
        String sql = "SELECT * FROM bookings WHERE booking_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    // අතුරුදහන් වී තිබූ mapRow ක්‍රමවේදය (Helper Method)
    private Booking mapRow(ResultSet rs) throws SQLException {
        Booking b = new Booking();
        b.setBookingId(rs.getInt("booking_id"));
        b.setRequestId(rs.getInt("request_id"));
        b.setCustomerId(rs.getInt("customer_id"));
        b.setWorkerId(rs.getInt("worker_id"));
        b.setBookingDate(rs.getString("booking_date"));
        b.setServiceDate(rs.getString("service_date"));
        b.setServiceTime(rs.getString("service_time"));
        b.setBookingStatus(rs.getString("booking_status"));
        b.setPaymentStatus(rs.getString("payment_status"));
        b.setTotalAmount(rs.getDouble("total_amount"));
        b.setNotes(rs.getString("notes"));
        return b;
    }

    public List<Booking> getJobsByWorker(int workerId) {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT * FROM bookings WHERE worker_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, workerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }
}