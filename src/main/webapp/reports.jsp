<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head><title>Reports</title></head>
<body>
    <h2>System Reports</h2>

    <%-- Admin View --%>
    <c:if test="${sessionScope.userType == 'ADMIN'}">
        <p>Total Bookings: ${total}</p>
        <p>Active Bookings: ${active}</p>
        <p>Cancelled Bookings: ${cancelled}</p>
    </c:if>

    <%-- Customer/Worker View --%>
    <table border="1">
        <tr><th>ID</th><th>Date</th><th>Status</th></tr>
        <c:forEach var="b" items="${history != null ? history : completed}">
            <tr><td>${b.bookingId}</td><td>${b.serviceDate}</td><td>${b.bookingStatus}</td></tr>
        </c:forEach>
    </table>
</body>
</html>