package com.mycompany.servicehub.model;

import java.sql.Timestamp;

public class Notification {
    private int notificationId;
    private int senderId;
    private int receiverId;
    private String title;
    private String message;
    private String type;
    private boolean isRead;
    private Timestamp createdAt;

    public Notification() {}

    // Convenience constructor: senderId, receiverId, title, message, type
    public Notification(int senderId, int receiverId, String title, String message, String type) {
        this.senderId = senderId;
        this.receiverId = receiverId;
        this.title = title;
        this.message = message;
        this.type = type;
    }

    public int getNotificationId() { return notificationId; }
    public void setNotificationId(int notificationId) { this.notificationId = notificationId; }

    public int getSenderId() { return senderId; }
    public void setSenderId(int senderId) { this.senderId = senderId; }

    public int getReceiverId() { return receiverId; }
    public void setReceiverId(int receiverId) { this.receiverId = receiverId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public boolean isRead() { return isRead; }
    public void setRead(boolean read) { this.isRead = read; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    // Aliases to support EL in JSPs
    public int getId() { return notificationId; }
    public int getRecipient() { return receiverId; }
}