package com.mycompany.servicehub.dao;

import com.mycompany.servicehub.model.SystemSettings;
import java.sql.*;

public class SettingsDAO {
    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/servicehub", "root", "password");
    }

    // Update system configuration
    public void updateSettings(SystemSettings s) {
        String sql = "UPDATE system_settings SET website_name=?, email=?, phone=?, timezone=?, maintenance=?, banner=? WHERE id=1";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, s.getWebsiteName());
            ps.setString(2, s.getContactEmail());
            ps.setString(3, s.getContactNumber());
            ps.setString(4, s.getTimeZone());
            ps.setBoolean(5, s.isMaintenanceMode());
            ps.setString(6, s.getBannerText());
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }
}