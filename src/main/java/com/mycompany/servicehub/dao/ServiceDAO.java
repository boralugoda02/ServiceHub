package com.mycompany.servicehub.dao;

import com.mycompany.servicehub.config.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class ServiceDAO {

    // Save a new service request (Customer posts a job)
    public boolean saveRequest(int customerId, String title, String category, double budget, String status, String city) {
    // Budget එක 0 ට වඩා වැඩි අගයක් (උදා: 1.0) විය යුතු බැවින් එය ආරක්ෂිතව සකසමු
    double finalBudget = (budget <= 0) ? 1.0 : budget;

    String query = "INSERT INTO service_requests (customer_id, service_title, category, budget, status, city) VALUES (?, ?, ?, ?, ?, ?)";
    
    try (Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(query)) {
        
        ps.setInt(1, customerId);
        ps.setString(2, title);
        ps.setString(3, category);
        ps.setDouble(4, finalBudget); // 1.0 ලෙස ආරක්ෂිතව ඇතුළත් වේ
        ps.setString(5, status);
        ps.setString(6, city);
        
        int rowsAffected = ps.executeUpdate();
        return rowsAffected > 0;
    } catch (Exception e) {
        e.printStackTrace(); // NetBeans Console එකේ සැබෑ වැරැද්ද බැලීමට මෙය අත්‍යවශ්‍යයි
        return false;
    }
}
    // Worker accepts a service request (assign worker_id and update status)
    public boolean acceptJob(int requestId, int workerId) throws Exception {
        String query = "UPDATE service_requests SET worker_id = ?, status = 'Accepted' WHERE id = ? AND worker_id IS NULL";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, workerId);
            ps.setInt(2, requestId);

            int rows = ps.executeUpdate();
            return rows > 0;
        }
    }
}