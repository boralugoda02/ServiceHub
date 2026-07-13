package com.mycompany.servicehub.dao;

import java.sql.*;
import java.util.HashMap;
import java.util.Map;

public class ReportDAO {
    // Database connection helper
    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/servicehub", "root", "password");
    }

    // Get counts for dashboard and reports
    public Map<String, Integer> getSystemStats() {
        Map<String, Integer> stats = new HashMap<>();
        String[] queries = {
            "users", "SELECT COUNT(*) FROM users",
            "bookings", "SELECT COUNT(*) FROM bookings",
            "services", "SELECT COUNT(*) FROM services",
            "reviews", "SELECT COUNT(*) FROM reviews"
        };

        try (Connection conn = getConnection()) {
            for (int i = 0; i < queries.length; i += 2) {
                try (Statement st = conn.createStatement(); ResultSet rs = st.executeQuery(queries[i+1])) {
                    if (rs.next()) stats.put(queries[i], rs.getInt(1));
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return stats;
    }
}
