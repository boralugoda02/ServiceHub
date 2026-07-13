package com.mycompany.servicehub.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import com.mycompany.servicehub.model.User;

/**
 * Filter to protect booking-related pages by ensuring 
 * the user is authenticated (logged in).
 */
@WebFilter("/bookings/*")
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization logic if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        // Get the current session, return null if no session exists
        HttpSession session = httpRequest.getSession(false);

        // Check if session exists and if user attribute is set
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);

        if (isLoggedIn) {
            // User is authorized, continue the request
            chain.doFilter(request, response);
        } else {
            // User is not authorized, redirect to the login page
            // Adjust the path "../login.jsp" according to your project structure
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp?error=AccessDenied");
        }
    }

    @Override
    public void destroy() {
        // Cleanup logic if needed
    }
}