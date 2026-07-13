package com.mycompany.servicehub.model;

public class JobApplication {
    private int applicationId;
    private int requestId;
    private int workerId;
    private String status;

    public JobApplication() {}

    // Getters and setters
    public int getApplicationId() { return applicationId; }
    public void setApplicationId(int applicationId) { this.applicationId = applicationId; }
    public int getRequestId() { return requestId; }
    public void setRequestId(int requestId) { this.requestId = requestId; }
    public int getWorkerId() { return workerId; }
    public void setWorkerId(int workerId) { this.workerId = workerId; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    @Override
    public String toString() {
        return "JobApplication{id=" + applicationId + ", status='" + status + "'}";
    }
}