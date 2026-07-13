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

@WebFilter("/admin/*")
public class AdminFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        // false යොදා ගැනීමෙන් දැනට පවතින session එක පමණක් ලබා ගනී
        HttpSession session = httpRequest.getSession(false);

        // Session එක පවතීද සහ User role එක 'admin' ද යන්න පරීක්ෂා කිරීම
        com.mycompany.servicehub.model.User user = (session != null) ? (com.mycompany.servicehub.model.User) session.getAttribute("user") : null;
        boolean isAdmin = (user != null && "Admin".equalsIgnoreCase(user.getRole()));

        if (isAdmin) {
            // පරිපාලකවරයෙක් නම් පමණක් පිටුවට යාමට ඉඩ දේ
            chain.doFilter(request, response);
        } else {
            // අවසර නැතිනම් login පිටුවට යොමු කරයි
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp?error=unauthorized");
        }
    }

    @Override
    public void destroy() {
        // Cleanup code if needed
    }
}