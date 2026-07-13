package com.mycompany.servicehub.service;

/**
 * Service class to handle system notifications.
 */
public class NotificationService {

    /**
     * Sends a notification to the user.
     * For demonstration, this prints to the server console.
     */
    public void sendNotification(String toEmail, String subject, String message) {
        // Here you would implement JavaMail API logic for real emails.
        // For the demo, we log to the console.
        System.out.println("----------------------------------------");
        System.out.println("NOTIFICATION SENT TO: " + toEmail);
        System.out.println("SUBJECT: " + subject);
        System.out.println("MESSAGE: " + message);
        System.out.println("----------------------------------------");
    }
}