<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="com.mycompany.servicehub.dao.NotificationDAO"%>
<%
    NotificationDAO notificationDAO = new NotificationDAO();
    request.setAttribute("notificationList", notificationDAO.getAllNotifications());
%>
<!DOCTYPE html>
<html>
<head>
    <title>Notification Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h3 class="mb-4">System Notifications</h3>
    
    <div class="card p-4 shadow-sm mb-4">
        <h5>Send Broadcast Announcement</h5>
        <form action="../NotificationServlet" method="POST" class="mt-3">
            <input type="hidden" name="action" value="broadcast">
            <textarea name="message" class="form-control mb-3" placeholder="Type your announcement here..." required></textarea>
            <button type="submit" class="btn btn-primary">Broadcast to All</button>
        </form>
    </div>

    <table class="table table-bordered bg-white shadow-sm">
        <thead class="table-dark">
            <tr><th>ID</th><th>Message</th><th>Recipient</th><th>Action</th></tr>
        </thead>
        <tbody>
            <c:forEach var="n" items="${notificationList}">
                <tr>
                    <td>${n.id}</td>
                    <td>${n.message}</td>
                    <td>${n.recipient}</td>
                    <td>
                        <a href="../NotificationServlet?action=delete&id=${n.id}" 
                           class="btn btn-danger btn-sm" onclick="return confirm('Delete this notification?')">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>