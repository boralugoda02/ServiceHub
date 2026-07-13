package com.mycompany.servicehub.servlet;

import com.mycompany.servicehub.dao.UserDAO;
import com.mycompany.servicehub.model.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        User user = new User();
        user.setUsername(request.getParameter("username"));
        user.setPassword(request.getParameter("password"));
        user.setEmail(request.getParameter("email"));
        user.setRole(request.getParameter("role"));
        user.setCity(request.getParameter("city"));
        user.setFullName(request.getParameter("fullName"));
        user.setNic(request.getParameter("nic"));
        user.setPhone(request.getParameter("phoneNumber"));
        user.setDistrict(request.getParameter("district"));
        user.setAddress(request.getParameter("address"));
        user.setSkills(request.getParameter("skills"));
        user.setEquipment(request.getParameter("equipment"));
        new UserDAO().saveUser(user);
        response.sendRedirect("login.jsp?success=registered");
    }
}