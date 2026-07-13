package com.mycompany.servicehub.servlet;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * ChatbotServlet handles incoming user queries and provides 
 * pre-defined responses to guide the user through the application.
 */
@WebServlet("/ChatbotServlet")
public class ChatbotServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        // Retrieve the user query from the request parameter
        String query = request.getParameter("query");
        
        // Default response if query is empty
        String answer;
        
        if (query == null || query.isEmpty()) {
            answer = "Hello! How can I help you today? You can ask me about services, booking status, or how to accept jobs.";
        } else {
            // Convert to lowercase for easier matching
            String lowerQuery = query.toLowerCase();

            // Logic to provide guidance based on keywords
            if (lowerQuery.contains("request") || lowerQuery.contains("service")) {
                answer = "To request a service, navigate to the 'Available Services' page, select a provider, and click 'Book Now'.";
            } 
            else if (lowerQuery.contains("accept")) {
                answer = "To accept a job, go to your 'Dashboard', view your pending job requests, and click the 'Accept' button.";
            } 
            else if (lowerQuery.contains("status") || lowerQuery.contains("booking")) {
                answer = "You can track your booking status in the 'My Bookings' section of your profile.";
            } 
            else if (lowerQuery.contains("contact") || lowerQuery.contains("help")) {
                answer = "You can contact our support team at support@servicehub.com or call us at 011-1234567.";
            } 
            else {
                answer = "I'm sorry, I don't have information on that. Try asking about 'booking', 'services', or 'contact'.";
            }
        }

        // Set response type and write the answer back to the frontend
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(answer);
    }
}