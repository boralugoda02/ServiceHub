package com.mycompany.servicehub.dao;

import com.mycompany.servicehub.model.ServiceRequest;
import com.mycompany.servicehub.config.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ServiceRequestDAO {

    /**
     * Inserts a new service request into the database.
     */
    public boolean saveRequest(ServiceRequest sr) {
        String sql = "INSERT INTO service_requests (customer_id, category_id, title, description, location, status) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, sr.getCustomerId());
            ps.setInt(2, sr.getCategoryId());
            ps.setString(3, sr.getTitle());
            ps.setString(4, sr.getDescription());
            ps.setString(5, sr.getLocation());
            ps.setString(6, sr.getStatus());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Retrieves all service requests that are currently in 'Pending' status.
     */
    public List<ServiceRequest> getAllPendingRequests() {
        List<ServiceRequest> list = new ArrayList<>();
        String sql = "SELECT * FROM service_requests WHERE status = 'Pending'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                ServiceRequest sr = new ServiceRequest();
                sr.setRequestId(rs.getInt("request_id"));
                sr.setTitle(rs.getString("title"));
                sr.setDescription(rs.getString("description"));
                sr.setLocation(rs.getString("location"));
                list.add(sr);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Retrieves a specific service request by its unique ID.
     */
    public ServiceRequest getRequestById(int id) {
        String sql = "SELECT * FROM service_requests WHERE request_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                ServiceRequest sr = new ServiceRequest();
                sr.setRequestId(rs.getInt("request_id"));
                sr.setTitle(rs.getString("title"));
                sr.setDescription(rs.getString("description"));
                sr.setLocation(rs.getString("location"));
                sr.setStatus(rs.getString("status"));
                return sr;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Updates the status of a service request (e.g., to 'Accepted', 'Completed').
     */
    public boolean updateStatus(int requestId, String status) {
        String sql = "UPDATE service_requests SET status = ? WHERE request_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, status);
            ps.setInt(2, requestId);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Retrieves all requests posted by a specific customer.
     */
    public List<ServiceRequest> getRequestsByCustomerId(int customerId) {
        List<ServiceRequest> list = new ArrayList<>();
        String sql = "SELECT * FROM service_requests WHERE customer_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                ServiceRequest sr = new ServiceRequest();
                sr.setRequestId(rs.getInt("request_id"));
                sr.setTitle(rs.getString("title"));
                sr.setStatus(rs.getString("status"));
                list.add(sr);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int saveRequestAndGetId(ServiceRequest sr) {
        String sql = "INSERT INTO service_requests (customer_id, category_id, title, description, location, status) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setInt(1, sr.getCustomerId());
            ps.setInt(2, sr.getCategoryId());
            ps.setString(3, sr.getTitle());
            ps.setString(4, sr.getDescription());
            ps.setString(5, sr.getLocation());
            ps.setString(6, sr.getStatus() != null ? sr.getStatus() : "Pending");
            
            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        return generatedKeys.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }
}