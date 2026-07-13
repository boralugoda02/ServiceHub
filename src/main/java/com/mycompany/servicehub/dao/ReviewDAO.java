package com.mycompany.servicehub.dao;

import com.mycompany.servicehub.model.Review;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO {
    private Connection getConnection() throws SQLException {
        return com.mycompany.servicehub.config.DBConnection.getConnection();
    }

    // Add a new review and return true if successful
    public boolean addReview(Review r) {
        String sql = "INSERT INTO reviews (booking_id, reviewed_user_id, reviewer_id, comment, rating) VALUES (?,?,?,?,?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, r.getBookingId());
            ps.setInt(2, r.getReviewedUserId());
            ps.setInt(3, r.getReviewerId());
            ps.setString(4, r.getComment());
            ps.setInt(5, r.getRating());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { 
            e.printStackTrace(); 
            return false; 
        }
    }

    // Update an existing review
    public void updateReview(Review r) {
        String sql = "UPDATE reviews SET comment=?, rating=? WHERE id=?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, r.getComment());
            ps.setInt(2, r.getRating());
            ps.setInt(3, r.getId());
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    // Get reviews list for a specific user
    public List<Review> getReviewsByUser(int userId) {
        List<Review> list = new ArrayList<>();
        String sql = "SELECT * FROM reviews WHERE reviewer_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Review r = new Review();
                r.setId(rs.getInt("id"));
                r.setComment(rs.getString("comment"));
                list.add(r);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    // Delete a review
    public void deleteReview(int id) {
        String sql = "DELETE FROM reviews WHERE id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }
}