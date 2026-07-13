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
    <title>Notification Management - Admin</title>
    <%@include file="../header.jsp" %>
</head>
<body>
    <jsp:include page="../common/sidebar.jsp" />

    <div class="main-content">
        <div class="container-fluid">
            <h3 class="fw-bold text-dark mb-4">System Notifications</h3>
            
            <div class="card p-4 shadow-sm mb-4 border-0 bg-white">
                <h5 class="fw-bold text-dark">Send Broadcast Announcement</h5>
                <form action="${pageContext.request.contextPath}/NotificationServlet" method="POST" class="mt-3">
                    <input type="hidden" name="action" value="broadcast">
                    <textarea name="message" class="form-control mb-3" placeholder="Type your announcement here..." required></textarea>
                    <button type="submit" class="btn btn-primary fw-semibold">Broadcast to All</button>
                </form>
            </div>

            <div class="card p-3 shadow-sm border-0 bg-white">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>ID</th>
                                <th>Message</th>
                                <th>Recipient ID</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="n" items="${notificationList}">
                                <tr>
                                    <td>#${n.id}</td>
                                    <td>${n.message}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${n.recipient == 0}">
                                                <span class="badge bg-secondary">All (Broadcast)</span>
                                            </c:when>
                                            <c:otherwise>
                                                User #${n.recipient}
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/NotificationServlet?action=delete&id=${n.id}" 
                                           class="btn btn-danger btn-sm fw-semibold" onclick="return confirm('Delete this notification?')">
                                           <i class="fas fa-trash-alt me-1"></i>Delete
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>