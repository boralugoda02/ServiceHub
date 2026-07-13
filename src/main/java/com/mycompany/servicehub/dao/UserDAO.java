package com.mycompany.servicehub.dao;

import com.mycompany.servicehub.model.User;
import com.mycompany.servicehub.config.DBConnection;
import org.mindrot.jbcrypt.BCrypt;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    // Database connection helper
    private Connection getConnection() throws SQLException {
        return DBConnection.getConnection();
    }

    // Validate User method (kept from original)
    public boolean validateUser(String email, String password) {
        String sql = "SELECT password FROM users WHERE email = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String hashed = rs.getString("password");
                    if (hashed != null && (hashed.startsWith("$2a$") || hashed.startsWith("$2b$") || hashed.startsWith("$2y$"))) {
                        return BCrypt.checkpw(password, hashed);
                    } else {
                        return password.equals(hashed);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Optional: Get user ID by email to use in Audit Logs (kept from original)
    public int getUserIdByEmail(String email) {
        String sql = "SELECT user_id FROM users WHERE email = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt("user_id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Save a new user (Registration)
    public void saveUser(User u) {
        String sql = "INSERT INTO users (full_name, email, phone, nic, password, role, city, district, address, skills, equipment, status, availability_status) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, u.getFullName());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getPhone());
            ps.setString(4, u.getNic());
            
            String password = u.getPassword();
            if (password != null && !password.startsWith("$2a$")) {
                password = BCrypt.hashpw(password, BCrypt.gensalt());
            }
            ps.setString(5, password);
            
            String role = u.getRole();
            String dbRole = "customer";
            if ("Customer".equalsIgnoreCase(role)) {
                dbRole = "customer";
            } else if ("Worker".equalsIgnoreCase(role) || "service_provider".equalsIgnoreCase(role)) {
                dbRole = "service_provider";
            } else if ("Admin".equalsIgnoreCase(role)) {
                dbRole = "admin";
            } else if (role != null) {
                dbRole = role.toLowerCase();
            }
            ps.setString(6, dbRole);
            ps.setString(7, u.getCity());
            ps.setString(8, u.getDistrict());
            ps.setString(9, u.getAddress());
            ps.setString(10, u.getSkills());
            ps.setString(11, u.getEquipment());
            ps.setString(12, u.getStatus() != null ? u.getStatus() : "Available");
            ps.setString(13, u.getAvailabilityStatus() != null ? u.getAvailabilityStatus() : "Available");
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Login by email + password
    public User login(String email, String password) {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String hashed = rs.getString("password");
                    boolean matches = false;
                    if (hashed != null && (hashed.startsWith("$2a$") || hashed.startsWith("$2b$") || hashed.startsWith("$2y$"))) {
                        matches = BCrypt.checkpw(password, hashed);
                    } else {
                        matches = password.equals(hashed);
                    }
                    if (matches) {
                        return mapRow(rs);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get a user by their email address
    public User getUserByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get a user by their ID
    public User getUserById(int userId) {
        String sql = "SELECT * FROM users WHERE user_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Find worker IDs located in a given city
    public List<Integer> getNearbyWorkers(String city) {
        List<Integer> workerIds = new ArrayList<>();
        String sql = "SELECT user_id FROM users WHERE city = ? AND role = 'Worker'";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, city);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    workerIds.add(rs.getInt("user_id"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return workerIds;
    }

    // Update a worker's availability status (Available / Busy / Offline)
    public boolean updateStatus(int userId, String status) {
        String sql = "UPDATE users SET status = ? WHERE user_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Verify old password matches (placeholder - implement real check as needed)
    public boolean checkPassword(int userId, String oldPass) {
        String sql = "SELECT password FROM users WHERE user_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String hashed = rs.getString("password");
                    if (hashed != null && (hashed.startsWith("$2a$") || hashed.startsWith("$2b$") || hashed.startsWith("$2y$"))) {
                        return BCrypt.checkpw(oldPass, hashed);
                    } else {
                        return oldPass.equals(hashed);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Update password by email
    public boolean updatePassword(String email, String newPass) {
        String sql = "UPDATE users SET password = ? WHERE email = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            String hashed = newPass;
            if (newPass != null && !newPass.startsWith("$2a$")) {
                hashed = BCrypt.hashpw(newPass, BCrypt.gensalt());
            }
            ps.setString(1, hashed);
            ps.setString(2, email);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update profile photo path
    public boolean updateProfilePhoto(int userId, String path) {
        String sql = "UPDATE users SET profile_photo = ? WHERE user_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, path);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete a user by their ID (admin use)
    public boolean deleteUser(int userId) {
        String sql = "DELETE FROM users WHERE user_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update a user's account status (admin use)
    public boolean updateUserStatus(int userId, String status) {
        String sql = "UPDATE users SET status = ? WHERE user_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get all users (admin use)
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                users.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    // Update user profile information
    public boolean updateProfile(int userId, String fullName, String phone, String address, String skills) {
        String sql = "UPDATE users SET full_name = ?, phone = ?, address = ?, skills = ? WHERE user_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, fullName);
            ps.setString(2, phone);
            ps.setString(3, address);
            ps.setString(4, skills);
            ps.setInt(5, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Helper method to map a ResultSet row to a User object
    private User mapRow(ResultSet rs) throws SQLException {
        User u = new User();
        u.setUserId(rs.getInt("user_id"));
        u.setUsername(rs.getString("email")); // fallback since no username column exists
        u.setEmail(rs.getString("email"));
        u.setPassword(rs.getString("password"));
        
        String dbRole = rs.getString("role");
        if ("customer".equals(dbRole)) {
            u.setRole("Customer");
        } else if ("service_provider".equals(dbRole)) {
            u.setRole("Worker");
        } else if ("admin".equals(dbRole)) {
            u.setRole("Admin");
        } else {
            u.setRole(dbRole);
        }
        
        u.setCity(rs.getString("city"));
        u.setFullName(rs.getString("full_name"));
        u.setNic(rs.getString("nic"));
        u.setPhone(rs.getString("phone"));
        u.setDistrict(rs.getString("district"));
        u.setAddress(rs.getString("address"));
        u.setSkills(rs.getString("skills"));
        u.setEquipment(rs.getString("equipment"));
        u.setProfilePhoto(rs.getString("profile_photo"));
        u.setStatus(rs.getString("status"));
        u.setAvailabilityStatus(rs.getString("availability_status"));
        return u;
    }
}