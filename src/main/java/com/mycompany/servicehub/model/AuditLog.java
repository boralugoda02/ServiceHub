package com.mycompany.servicehub.model;

import java.sql.Timestamp;

public class AuditLog {
    private int id;
    private String username;
    private String action;
    private Timestamp timestamp;

    public AuditLog() {}

    public AuditLog(int id, String username, String action, Timestamp timestamp) {
        this.id = id;
        this.username = username;
        this.action = action;
        this.timestamp = timestamp;
    }

    // Getters and Setters
    public int getId() { return id; }
    public String getUsername() { return username; }
    public String getAction() { return action; }
    public Timestamp getTimestamp() { return timestamp; }
}