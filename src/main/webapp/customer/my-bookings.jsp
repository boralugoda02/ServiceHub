<%@ page import="com.mycompany.servicehub.model.*, com.mycompany.servicehub.service.*, java.util.*" %>
<%
    // Check if user is logged in
    com.mycompany.servicehub.model.User user = (com.mycompany.servicehub.model.User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
    Integer customerId = user.getUserId();

    // Initialize Service layer
    BookingService bookingService = new BookingService();
    List<Booking> allBookings = bookingService.getCustomerBookings(customerId);
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Bookings</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="container">
        <h2>My Bookings</h2>
        
        <table class="table">
            <thead>
                <tr>
                    <th>Date</th>
                    <th>Time</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% for (Booking b : allBookings) { %>
                <tr>
                    <td><%= b.getServiceDate() %></td>
                    <td><%= b.getServiceTime() %></td>
                    <td><%= b.getBookingStatus() %></td>
                    <td>
                        <a href="booking-details.jsp?id=<%= b.getBookingId() %>" class="btn btn-info">View</a>
                        
                        <% if (!b.getBookingStatus().equals("Completed") && !b.getBookingStatus().equals("Cancelled")) { %>
                        <form action="../BookingServlet" method="POST" style="display:inline;">
                            <input type="hidden" name="action" value="cancel">
                            <input type="hidden" name="bookingId" value="<%= b.getBookingId() %>">
                            <button type="submit" class="btn btn-danger" onclick="return confirm('Are you sure?')">Cancel</button>
                        </form>
                        <% } %>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>