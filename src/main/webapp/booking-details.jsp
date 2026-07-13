<%@ page import="com.mycompany.servicehub.model.*, com.mycompany.servicehub.service.*" %>
<%
    // Get booking ID from URL parameter
    int bId = Integer.parseInt(request.getParameter("id"));
    BookingService service = new BookingService();
    Booking b = service.getBookingDetails(bId); // Fetches booking object
%>

<!DOCTYPE html>
<html>
<head>
    <title>Booking Details</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="container">
        <h2>Booking Details - #<%= b.getBookingId() %></h2>
        
        <div class="details-card">
            <p><strong>Service Category:</strong> <%= b.getRequestId() %></p> <p><strong>Service Date:</strong> <%= b.getServiceDate() %></p>
            <p><strong>Time:</strong> <%= b.getServiceTime() %></p>
            <p><strong>Total Amount:</strong> Rs. <%= b.getTotalAmount() %></p>
            <p><strong>Status:</strong> <%= b.getBookingStatus() %></p>
            <p><strong>Customer Notes:</strong> <%= b.getNotes() %></p>
        </div>

        <a href="my-bookings.jsp" class="btn btn-secondary">Back to My Bookings</a>
    </div>
</body>
</html>