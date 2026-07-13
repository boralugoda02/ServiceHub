package com.mycompany.servicehub.model;

public class Request {
    private int id;
    private String service;
    private String status;

    // Constructors
    public Request() {}

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getService() { return service; }
    public void setService(String service) { this.service = service; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}