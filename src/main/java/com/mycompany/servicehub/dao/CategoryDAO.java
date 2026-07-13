package com.mycompany.servicehub.dao;

import com.mycompany.servicehub.config.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for managing service categories.
 */
public class CategoryDAO {

    // Database connection configuration
    private Connection getConnection() throws SQLException {
        return DBConnection.getConnection();
    }

    // 1. Add a new service category
    public void addCategory(String name) {
        String sql = "INSERT INTO service_categories (category_name) VALUES (?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.executeUpdate();
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
    }

    // 2. Retrieve all categories to display in Admin Panel
    public List<String> getAllCategories() {
        List<String> list = new ArrayList<>();
        String sql = "SELECT category_name FROM service_categories";
        try (Connection conn = getConnection(); Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(rs.getString("category_name"));
            }
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
        return list;
    }

    // 3. Delete a category by name
    public void deleteCategory(String name) {
        String sql = "DELETE FROM service_categories WHERE category_name = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.executeUpdate();
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
    }
}