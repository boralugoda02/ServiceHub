package com.mycompany.servicehub.servlet;

import com.mycompany.servicehub.dao.CategoryDAO;
import com.mycompany.servicehub.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet to handle Add and Delete operations for Service Categories.
 */
@WebServlet("/admin/CategoryServlet")
public class CategoryServlet extends HttpServlet {
    
    private CategoryDAO dao = new CategoryDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null || !"Admin".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=UnauthorizedAccess");
            return;
        }

        // Retrieve the action parameter (add or delete)
        String action = request.getParameter("action");
        
        // Handle logic based on action
        if ("add".equals(action)) {
            String categoryName = request.getParameter("categoryName");
            if (categoryName != null && !categoryName.trim().isEmpty()) {
                dao.addCategory(categoryName);
            }
        } else if ("delete".equals(action)) {
            String categoryName = request.getParameter("categoryName");
            if (categoryName != null) {
                dao.deleteCategory(categoryName);
            }
        }
        
        // Redirect back to the admin categories page to refresh the list
        response.sendRedirect(request.getContextPath() + "/admin/categories.jsp");
    }

    // Optional: Handle GET requests as well if needed
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doPost(request, response);
    }
}