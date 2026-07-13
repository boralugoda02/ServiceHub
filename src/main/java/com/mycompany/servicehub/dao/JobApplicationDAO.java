package com.mycompany.servicehub.dao;

import com.mycompany.servicehub.model.ServiceRequest;
import com.mycompany.servicehub.config.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class JobApplicationDAO {

    // Apply for a job (Insert into job_applications)
    public boolean applyForJob(int requestId, int workerId) {
        String sql = "INSERT INTO job_applications (request_id, worker_id, status) VALUES (?, ?, 'Accepted')";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, requestId);
            ps.setInt(2, workerId);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get all jobs accepted by a specific worker
    public List<ServiceRequest> getJobsByWorkerId(int workerId) {
        List<ServiceRequest> list = new ArrayList<>();
        String sql = "SELECT sr.* FROM service_requests sr " +
                     "JOIN job_applications ja ON sr.request_id = ja.request_id " +
                     "WHERE ja.worker_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, workerId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                ServiceRequest sr = new ServiceRequest();
                sr.setRequestId(rs.getInt("request_id"));
                sr.setTitle(rs.getString("title"));
                sr.setDescription(rs.getString("description"));
                sr.setLocation(rs.getString("location"));
                sr.setStatus(rs.getString("status"));
                list.add(sr);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}