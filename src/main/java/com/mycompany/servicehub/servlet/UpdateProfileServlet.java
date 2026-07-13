package com.mycompany.servicehub.servlet;

import com.mycompany.servicehub.dao.UserDAO;
import com.mycompany.servicehub.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/update-profile")
public class UpdateProfileServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp?error=SessionExpired");
            return;
        }

        String fullName = request.getParameter("fullName");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        String skills = request.getParameter("skills");

        boolean isUpdated = userDAO.updateProfile(user.getUserId(), fullName, phoneNumber, address, skills);

        if (isUpdated) {
            // Update the User object in session
            user.setFullName(fullName);
            user.setPhone(phoneNumber);
            user.setAddress(address);
            user.setSkills(skills);
            session.setAttribute("user", user);
            session.setAttribute("userName", fullName);

            response.sendRedirect("profile.jsp?status=success");
        } else {
            response.sendRedirect("profile.jsp?error=UpdateFailed");
        }
    }
}