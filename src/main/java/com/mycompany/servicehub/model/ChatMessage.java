package com.mycompany.servicehub.model;

public class ChatMessage {
    private int id;
    private int senderId;
    private int receiverId;
    private int bookingId;
    private String message;
    private boolean isReported;

    // Default Constructor
    public ChatMessage() {}

    // Parameterized Constructor matching ChatServlet call
    public ChatMessage(int senderId, int receiverId, int bookingId, String message) {
        this.senderId = senderId;
        this.receiverId = receiverId;
        this.bookingId = bookingId;
        this.message = message;
    }

    // Constructor with id
    public ChatMessage(int id, int senderId, int receiverId, int bookingId, String message) {
        this.id = id;
        this.senderId = senderId;
        this.receiverId = receiverId;
        this.bookingId = bookingId;
        this.message = message;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getSenderId() { return senderId; }
    public void setSenderId(int senderId) { this.senderId = senderId; }

    public int getReceiverId() { return receiverId; }
    public void setReceiverId(int receiverId) { this.receiverId = receiverId; }

    public int getBookingId() { return bookingId; }
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public boolean isReported() { return isReported; }
    public void setReported(boolean isReported) { this.isReported = isReported; }
}