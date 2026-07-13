package com.mycompany.servicehub.dao;

import com.mycompany.servicehub.model.Request; // Ensure your Request model is imported
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for handling Service Requests.
 */
public class RequestDAO {

    // Helper method to establish database connection
    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/servicehub", "root", "password");
    }

    // Retrieve all service requests from the database
    public List<Request> getAllRequests() {
        List<Request> list = new ArrayList<>();
        String sql = "SELECT * FROM service_requests";
        try (Connection conn = getConnection(); Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Request r = new Request();
                r.setId(rs.getInt("id"));
                r.setService(rs.getString("service"));
                r.setStatus(rs.getString("status"));
                // Add any other fields you have in your model
                list.add(r);
            }
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
        return list;
    }

    // Update the status of a specific service request
    public void updateRequestStatus(int id, String status) {
        String sql = "UPDATE service_requests SET status = ? WHERE id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, id);
            ps.executeUpdate();
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
    }

    // Delete a service request by ID
    public void deleteRequest(int id) {
        String sql = "DELETE FROM service_requests WHERE id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
    }
}