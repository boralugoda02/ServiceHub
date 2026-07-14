<%@ page import="com.mycompany.servicehub.model.*, com.mycompany.servicehub.service.*" %>
<%
    User loggedInUser = (User) session.getAttribute("user");
    if (loggedInUser == null) {
        response.sendRedirect("../login.jsp?error=LoginRequired");
        return;
    }

    // Get booking ID from URL parameter
    String idParam = request.getParameter("id");
    if (idParam == null) {
        response.sendRedirect("my-bookings.jsp");
        return;
    }
    
    int bId = 0;
    try {
        bId = Integer.parseInt(idParam);
    } catch (NumberFormatException e) {
        response.sendRedirect("my-bookings.jsp?error=InvalidId");
        return;
    }

    BookingService service = new BookingService();
    Booking b = service.getBookingDetails(bId); // Fetches booking object
    
    if (b == null) {
        response.sendRedirect("my-bookings.jsp?error=BookingNotFound");
        return;
    }
    
    // Enforce authorization check (BOLA prevention)
    if (!"Admin".equalsIgnoreCase(loggedInUser.getRole()) && b.getCustomerId() != loggedInUser.getUserId()) {
        response.sendRedirect("my-bookings.jsp?error=UnauthorizedAccess");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Booking Details - #<%= b.getBookingId() %></title>
    <link rel="stylesheet" href="../css/style.css">
    <style>
        /* Timeline Styles */
        .timeline { display: flex; justify-content: space-between; margin: 30px 0; padding: 10px; background: #f8f9fa; border-radius: 8px; }
        .step { padding: 10px; border: 1px solid #ccc; flex-grow: 1; text-align: center; color: #666; font-size: 0.9em; }
        .step.active { background-color: #007bff; color: white; border-color: #007bff; font-weight: bold; }
        .step.completed { background-color: #28a745; color: white; border-color: #28a745; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Booking Details #<%= b.getBookingId() %></h2>
        
        <div class="timeline">
            <div class="step <%= b.getBookingStatus().equals("Pending") ? "active" : "completed" %>">Submitted</div>
            <div class="step <%= b.getBookingStatus().equals("Accepted") ? "active" : (b.getBookingStatus().equals("In Progress") || b.getBookingStatus().equals("Completed") ? "completed" : "") %>">Accepted</div>
            <div class="step <%= b.getBookingStatus().equals("In Progress") ? "active" : (b.getBookingStatus().equals("Completed") ? "completed" : "") %>">Started</div>
            <div class="step <%= b.getBookingStatus().equals("Completed") ? "completed" : "" %>">Completed</div>
        </div>

        <div class="details-card" style="border: 1px solid #ddd; padding: 20px; border-radius: 8px;">
            <p><strong>Service Date:</strong> <%= b.getServiceDate() %></p>
            <p><strong>Time:</strong> <%= b.getServiceTime() %></p>
            <p><strong>Status:</strong> <span class="badge"><%= b.getBookingStatus() %></span></p>
            <p><strong>Total Amount:</strong> Rs. <%= b.getTotalAmount() %></p>
            <p><strong>Notes:</strong> <%= b.getNotes() %></p>
        </div>

        <br>
        <a href="my-bookings.jsp" class="btn btn-secondary">Back to My Bookings</a>
    </div>
</body>
</html>