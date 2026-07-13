<%@ page import="com.mycompany.servicehub.model.*" %>
<%@ page import="com.mycompany.servicehub.dao.*" %>
<%
    // Session check
    if (session.getAttribute("user") == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
    // Booking ID ????????
    int bookingId = Integer.parseInt(request.getParameter("id"));
    BookingDAO dao = new BookingDAO();
    // Booking ?????? ???????? (DB ????? query ??)
    Booking b = dao.getBookingById(bookingId); 
%>

<!DOCTYPE html>
<html>
<head>
    <title>Booking Confirmation</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="container">
        <h2>Booking Details</h2>
        <table class="table">
            <tr><th>Booking Number:</th><td><%= b.getBookingId() %></td></tr>
            <tr><th>Service:</th><td><%= b.getRequestTitle() %></td></tr>
            <tr><th>Date:</th><td><%= b.getServiceDate() %></td></tr>
            <tr><th>Time:</th><td><%= b.getServiceTime() %></td></tr>
            <tr><th>Status:</th><td><%= b.getBookingStatus() %></td></tr>
        </table>

        <div class="actions">
            <form action="../BookingServlet" method="POST">
                <input type="hidden" name="action" value="confirm">
                <input type="hidden" name="bookingId" value="<%= b.getBookingId() %>">
                <button type="submit" class="btn btn-success">Confirm</button>
            </form>

            <form action="../BookingServlet" method="POST">
                <input type="hidden" name="action" value="cancel">
                <input type="hidden" name="bookingId" value="<%= b.getBookingId() %>">
                <button type="submit" class="btn btn-danger">Cancel</button>
            </form>
        </div>
    </div>
</body>
</html>