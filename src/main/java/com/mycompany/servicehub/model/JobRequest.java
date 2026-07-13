package com.mycompany.servicehub.model;

public class JobRequest {
    private int requestId;
    private int customerId;

    public JobRequest() {}
    public JobRequest(int requestId, int customerId) {
        this.requestId = requestId;
        this.customerId = customerId;
    }
    public int getRequestId() { return requestId; }
    public void setRequestId(int requestId) { this.requestId = requestId; }
    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }
    
    @Override
    public String toString() { return "JobRequest{id=" + requestId + ", customerId=" + customerId + "}"; }
}