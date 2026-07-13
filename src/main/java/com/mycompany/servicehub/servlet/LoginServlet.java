package com.mycompany.servicehub.servlet;

import com.mycompany.servicehub.dao.AuditLogDAO;
import com.mycompany.servicehub.dao.UserDAO;
import com.mycompany.servicehub.model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDAO userDAO = new UserDAO();

        // 1. පරිශීලකයා නිවැරදි දැයි පරීක්ෂා කිරීම
        if (userDAO.validateUser(email, password)) {

            // 2. අදාළ පරිශීලකයාගේ සම්පූර්ණ විස්තර ලබා ගැනීම
            User user = userDAO.getUserByEmail(email);

            // 3. Audit Log එකට වාර්තා කිරීම
            AuditLogDAO auditDAO = new AuditLogDAO();
            auditDAO.insertLog(user.getUserId(), "LOGIN", "User logged in successfully");

            // 4. Session එක ආරම්භ කිරීම - "user" attribute එකෙන්ම සම්පූර්ණ object එක save කිරීම
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            response.sendRedirect("dashboard.jsp");
        } else {
            // වැරදි මුරපදයක් නම්
            response.sendRedirect("login.jsp?error=InvalidLogin");
        }
    }
}