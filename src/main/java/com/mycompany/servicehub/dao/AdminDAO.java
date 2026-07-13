package com.mycompany.servicehub.dao;

import com.mycompany.servicehub.config.DBConnection;
import com.mycompany.servicehub.model.Admin;
import java.sql.*;

public class AdminDAO {

    // Database connection helper
    private Connection getConnection() throws SQLException {
        return DBConnection.getConnection();
    }

    // Update profile information in users table
    public void updateProfile(Admin admin) {
        String sql = "UPDATE users SET full_name = ?, email = ? WHERE user_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, admin.getUsername());
            ps.setString(2, admin.getEmail());
            ps.setInt(3, admin.getId());
            ps.executeUpdate();
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
    }

    // Change admin password in users table
    public void changePassword(int id, String newPassword) {
        String sql = "UPDATE users SET password = ? WHERE user_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setInt(2, id);
            ps.executeUpdate();
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
    }

    // Generic method to get counts from any table
    public int getCount(String tableName) {
        String sql = "SELECT COUNT(*) FROM " + tableName;
        try (Connection conn = getConnection(); Statement st = conn.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
        return 0;
    }

    // Specific count methods
    public int getActiveBookingsCount() { 
        return getCount("bookings WHERE booking_status = 'Active' OR booking_status = 'Confirmed'"); 
    }

    public int getCompletedJobsCount() { 
        return getCount("service_requests WHERE status = 'Completed'"); 
    }

    public int getPendingRequestsCount() { 
        return getCount("service_requests WHERE status = 'Pending'"); 
    }
}