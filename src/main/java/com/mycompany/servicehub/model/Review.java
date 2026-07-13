package com.mycompany.servicehub.model;

public class Review {
    private int id;
    private int bookingId;
    private int reviewedUserId;
    private int reviewerId;
    private String customerName;
    private String comment;
    private int rating;
    private boolean isReported;

    public Review() {}

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public void setReviewId(int id) { this.id = id; } // Added for servlet compatibility

    public int getBookingId() { return bookingId; }
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }

    public int getReviewedUserId() { return reviewedUserId; }
    public void setReviewedUserId(int reviewedUserId) { this.reviewedUserId = reviewedUserId; }

    public int getReviewerId() { return reviewerId; }
    public void setReviewerId(int reviewerId) { this.reviewerId = reviewerId; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String name) { this.customerName = name; }

    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }

    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }

    public boolean isReported() { return isReported; }
    public void setReported(boolean reported) { this.isReported = reported; }
}