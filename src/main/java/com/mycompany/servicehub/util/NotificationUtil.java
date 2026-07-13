package com.mycompany.servicehub.util;

import com.mycompany.servicehub.dao.NotificationDAO;
import com.mycompany.servicehub.model.Notification;

/**
 * Utility class to handle notification creation across the application.
 * This prevents code duplication in Servlets.
 */
public class NotificationUtil {
    
    // Instance of NotificationDAO to interact with the database
    private static NotificationDAO nDAO = new NotificationDAO();

    /**
     * Helper method to send a notification.
     * * @param senderId   The ID of the user or system sending the notification
     * @param receiverId The ID of the user receiving the notification
     * @param title      The short title of the notification
     * @param message    The main content of the notification
     * @param type       The category of notification (e.g., BOOKING, REVIEW)
     */
    public static void send(int senderId, int receiverId, String title, String message, String type) {
        // Create a new Notification object using the parameterized constructor
        Notification n = new Notification(senderId, receiverId, title, message, type);
        
        // Save the notification to the database using DAO
        nDAO.createNotification(n);
    }
}