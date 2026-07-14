package com.mycompany.servicehub.servlet;

import com.mycompany.servicehub.dao.BackupRestoreDAO;
import com.mycompany.servicehub.model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin/BackupServlet")
public class BackupServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null || !"Admin".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=UnauthorizedAccess");
            return;
        }

        BackupRestoreDAO br = new BackupRestoreDAO();
        String action = request.getParameter("action");
        
        if ("backup".equals(action)) {
            br.performBackup();
            response.sendRedirect(request.getContextPath() + "/admin/backup.jsp?status=BackupSuccessful");
        } else if ("restore".equals(action)) {
            br.performRestore();
            response.sendRedirect(request.getContextPath() + "/admin/backup.jsp?status=RestoreSuccessful");
        }
    }
}