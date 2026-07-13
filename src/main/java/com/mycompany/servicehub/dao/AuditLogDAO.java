package com.mycompany.servicehub.dao;

import com.mycompany.servicehub.config.DBConnection;
import java.sql.*;

public class AuditLogDAO {
    // Database connection helper
    private Connection getConnection() throws SQLException {
        return DBConnection.getConnection();
    }

    // Insert log method
    public void insertLog(int userId, String action, String description) {
        String sql = "INSERT INTO audit_logs (user_id, action, description) VALUES (?, ?, ?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, action);
            ps.setString(3, description);
            ps.executeUpdate();
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
    }
}