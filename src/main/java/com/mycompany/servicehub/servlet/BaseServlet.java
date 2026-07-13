package com.mycompany.servicehub.servlet;

import java.io.IOException;
// Import jakarta instead of javax
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public abstract class BaseServlet extends HttpServlet {

    // Helper method to check if user is logged in
    protected boolean isLoggedIn(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return (session != null && session.getAttribute("user") != null);
    }

    // Helper method to check authentication and redirect if not logged in
    protected boolean checkAuth(HttpServletRequest request, HttpServletResponse response) throws IOException {
        if (!isLoggedIn(request)) {
            // Redirect to login page using context path
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=PleaseLoginFirst");
            return false;
        }
        return true;
    }
}