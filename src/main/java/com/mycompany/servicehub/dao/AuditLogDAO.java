package com.mycompany.servicehub.dao;

import com.mycompany.servicehub.config.DBConnection;
import java.sql.*;

public class AuditLogDAO {
    // Database connection helper
    private Connection getConnection() throws SQLException {
        return DBConnection.getConnection();
    }

    // Insert log method (correctly targeting activity_logs table matching schema)
    public void insertLog(int userId, String action, String ipAddress) {
        String sql = "INSERT INTO activity_logs (user_id, action, ip_address) VALUES (?, ?, ?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, action);
            ps.setString(3, ipAddress);
            ps.executeUpdate();
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
    }
}