package com.mycompany.servicehub.dao;

import java.sql.*;
import java.util.HashMap;
import java.util.Map;

public class AnalyticsDAO {
    // Database connection helper
    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/servicehub", "root", "password");
    }

    // Retrieve analytics data from database
    public Map<String, Object> getAnalyticsData() {
        Map<String, Object> data = new HashMap<>();
        try (Connection conn = getConnection(); Statement st = conn.createStatement()) {
            
            // Daily Users (Counting distinct logins today)
            ResultSet rs = st.executeQuery("SELECT COUNT(DISTINCT user_id) FROM login_logs WHERE DATE(login_time) = CURDATE()");
            if (rs.next()) data.put("dailyUsers", rs.getInt(1));
            
            // Monthly Bookings
            rs = st.executeQuery("SELECT COUNT(*) FROM bookings WHERE MONTH(booking_date) = MONTH(CURDATE())");
            if (rs.next()) data.put("monthlyBookings", rs.getInt(1));
            
            // Most Requested Service
            rs = st.executeQuery("SELECT service_name FROM services ORDER BY request_count DESC LIMIT 1");
            if (rs.next()) data.put("topService", rs.getString(1));
            
            // Active Users
            rs = st.executeQuery("SELECT COUNT(*) FROM users WHERE status = 'active'");
            if (rs.next()) data.put("activeUsers", rs.getInt(1));

        } catch (SQLException e) { e.printStackTrace(); }
        return data;
    }
}
