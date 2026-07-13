package com.mycompany.servicehub.dao;

import com.mycompany.servicehub.model.ChatMessage;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ChatDAO {
    // Database connection helper
    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/servicehub", "root", "password");
    }

    // Retrieve all messages for monitoring
    public List<ChatMessage> getAllMessages() {
        List<ChatMessage> list = new ArrayList<>();
        String sql = "SELECT * FROM chat_messages";
        try (Connection conn = getConnection(); Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                ChatMessage cm = new ChatMessage();
                cm.setId(rs.getInt("id"));
                cm.setSenderId(rs.getInt("sender_id"));
                cm.setMessage(rs.getString("message"));
                cm.setReported(rs.getBoolean("is_reported"));
                list.add(cm);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    // Send a new message
    public void sendMessage(ChatMessage cm) {
        String sql = "INSERT INTO chat_messages (sender_id, receiver_id, message) VALUES (?,?,?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, cm.getSenderId());
            ps.setInt(2, cm.getReceiverId());
            ps.setString(3, cm.getMessage());
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    // Get conversation history
    public List<ChatMessage> getConversation(int chatId) {
        List<ChatMessage> list = new ArrayList<>();
        String sql = "SELECT * FROM chat_messages WHERE id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, chatId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new ChatMessage(rs.getInt("id"), rs.getInt("sender_id"), 
                                         rs.getInt("receiver_id"), rs.getString("message")));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    // Delete a message
    public void deleteMessage(int id) {
        String sql = "DELETE FROM chat_messages WHERE id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }
}