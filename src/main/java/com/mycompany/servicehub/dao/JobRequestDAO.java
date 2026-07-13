package com.mycompany.servicehub.dao;

import com.mycompany.servicehub.config.DBConnection;
import com.mycompany.servicehub.model.JobRequest;
import java.sql.*;

public class JobRequestDAO {
    public void save(JobRequest jr) throws Exception {
        String sql = "INSERT INTO job_requests (customer_id) VALUES (?)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, jr.getCustomerId());
            ps.executeUpdate();
        }
    }
}