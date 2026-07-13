package com.mycompany.servicehub.servlet;

import com.mycompany.servicehub.dao.BackupRestoreDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/BackupServlet")
public class BackupServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        BackupRestoreDAO br = new BackupRestoreDAO();
        String action = request.getParameter("action");
        
        if ("backup".equals(action)) {
            br.performBackup();
            response.sendRedirect("admin/backup.jsp?status=BackupSuccessful");
        } else if ("restore".equals(action)) {
            br.performRestore();
            response.sendRedirect("admin/backup.jsp?status=RestoreSuccessful");
        }
    }
}