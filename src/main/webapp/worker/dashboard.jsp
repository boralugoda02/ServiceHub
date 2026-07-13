<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Worker Dashboard</title>
</head>
<body>

    <h2>Worker Dashboard</h2>
    
    <div style="border: 1px solid #ddd; padding: 15px; width: 300px; border-radius: 8px;">
        <h3>Update Your Availability</h3>
        
        <form action="../UpdateStatusServlet" method="POST">
            <label>Current Status:</label>
            <select name="status" style="width: 100%; padding: 8px; margin: 10px 0;">
                <option value="Available" ${sessionScope.userStatus == 'Available' ? 'selected' : ''}>Available</option>
                <option value="Busy" ${sessionScope.userStatus == 'Busy' ? 'selected' : ''}>Busy</option>
                <option value="Offline" ${sessionScope.userStatus == 'Offline' ? 'selected' : ''}>Offline</option>
            </select>
            
            <button type="submit" style="background: #007bff; color: white; border: none; padding: 10px 20px; cursor: pointer;">
                Update Status
            </button>
        </form>
    </div>

    <c:if test="${not empty param.msg}">
        <p style="color: green;">Status updated successfully!</p>
    </c:if>

</body>
</html>