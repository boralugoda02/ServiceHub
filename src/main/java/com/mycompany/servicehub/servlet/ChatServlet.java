package com.mycompany.servicehub.servlet;

import com.mycompany.servicehub.dao.ChatDAO;
import com.mycompany.servicehub.model.ChatMessage;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/ChatServlet")
public class ChatServlet extends HttpServlet {
    private ChatDAO chatDAO = new ChatDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // 1. Authentication Check: Ensure user is logged in
        com.mycompany.servicehub.model.User user = (com.mycompany.servicehub.model.User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        Integer userId = user.getUserId();

        String action = request.getParameter("action");
        if ("SEND".equals(action)) {
            try {
                int bookingId = Integer.parseInt(request.getParameter("bookingId"));
                int receiverId = Integer.parseInt(request.getParameter("receiverId"));
                String messageContent = request.getParameter("message");

                // 2. Validation: Prevent empty or overly long messages
                if (messageContent == null || messageContent.trim().isEmpty() || messageContent.length() > 500) {
                    response.sendRedirect("ChatServlet?action=LOAD&bookingId=" + bookingId + "&error=InvalidMessage");
                    return;
                }

                // 3. Security: Send message
                ChatMessage msg = new ChatMessage(userId, receiverId, bookingId, messageContent.trim());
                chatDAO.sendMessage(msg);
                
                response.sendRedirect("ChatServlet?action=LOAD&bookingId=" + bookingId + "&receiverId=" + receiverId);
                
            } catch (NumberFormatException e) {
                response.sendRedirect("error.jsp");
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if ("LOAD".equals(action)) {
            try {
                int bookingId = Integer.parseInt(request.getParameter("bookingId"));
                
                request.setAttribute("messages", chatDAO.getConversation(bookingId));
                request.setAttribute("bookingId", bookingId);
                request.setAttribute("receiverId", request.getParameter("receiverId"));
                request.getRequestDispatcher("customer/chat.jsp").forward(request, response);
                
            } catch (NumberFormatException e) {
                response.sendRedirect("error.jsp");
            }
        }
    }
}