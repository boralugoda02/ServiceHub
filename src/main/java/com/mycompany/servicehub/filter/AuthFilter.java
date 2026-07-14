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
 * Filter to protect customer, worker, and booking pages by ensuring 
 * the user is authenticated (logged in) and has the correct role.
 */
@WebFilter(urlPatterns = {"/customer/*", "/worker/*", "/BookingServlet", "/ChatServlet"})
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
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            // User is not logged in, redirect to the login page
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp?error=LoginRequired");
            return;
        }

        String path = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());
        String role = user.getRole(); // "Customer", "Worker", "Admin"

        // Enforce customer paths
        if (path.startsWith("/customer/") && !"Customer".equalsIgnoreCase(role) && !"Admin".equalsIgnoreCase(role)) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/error.jsp?error=UnauthorizedAccess");
            return;
        }

        // Enforce worker paths
        if (path.startsWith("/worker/") && !"Worker".equalsIgnoreCase(role) && !"Admin".equalsIgnoreCase(role)) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/error.jsp?error=UnauthorizedAccess");
            return;
        }

        // User is authorized, continue the request
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Cleanup logic if needed
    }
}