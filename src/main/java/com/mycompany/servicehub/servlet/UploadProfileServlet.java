package com.mycompany.servicehub.servlet;

import com.mycompany.servicehub.dao.UserDAO;
import com.mycompany.servicehub.dao.AuditLogDAO;
import com.mycompany.servicehub.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.nio.file.*;

@WebServlet("/upload-photo")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 5,
    maxRequestSize = 1024 * 1024 * 10
)
public class UploadProfileServlet extends BaseServlet {
    private UserDAO userDAO = new UserDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect("login.jsp?error=SessionExpired");
            return;
        }

        Part filePart = request.getPart("profilePhoto");
        String rawFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        String extension = "";
        int i = rawFileName.lastIndexOf('.');
        if (i > 0) {
            extension = rawFileName.substring(i).toLowerCase();
        }
        if (!(extension.equals(".jpg") || extension.equals(".jpeg") || extension.equals(".png"))) {
            response.sendRedirect("profile.jsp?error=InvalidImageType");
            return;
        }

        // Generate a unique filename using userId and timestamp
        String fileName = "profile_" + user.getUserId() + "_" + System.currentTimeMillis() + extension;
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);

        String dbPath = "uploads/" + fileName;
        try {
            userDAO.updateProfilePhoto(user.getUserId(), dbPath);
            user.setProfilePhoto(dbPath);
            session.setAttribute("user", user);

            // Log the photo upload event
            logActivity(user.getUserId(), "Updated profile photo", request);

            response.sendRedirect("profile.jsp?status=photoUpdated");
        } catch (Exception e) {
            response.sendRedirect("profile.jsp?error=DatabaseUpdateFailed");
        }
    }

    private void sendError(HttpServletResponse res, String page, String error) throws IOException {
        res.sendRedirect(page + "?error=" + error);
    }

    // Helper method to log activity
    private void logActivity(int userId, String action, HttpServletRequest request) {
        String ipAddress = request.getRemoteAddr();
        AuditLogDAO logDAO = new AuditLogDAO();
        logDAO.insertLog(userId, action, ipAddress);
    }
}