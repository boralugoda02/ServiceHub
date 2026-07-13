<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.servicehub.dao.ServiceRequestDAO"%>
<%@page import="com.mycompany.servicehub.model.ServiceRequest"%>
<%@page import="com.mycompany.servicehub.model.User"%>
<%@page import="java.util.List"%>
<%@include file="../header.jsp" %>

<%
    // Verify authentication and get logged in user
    User user = (User) session.getAttribute("user");
    if (user == null) { response.sendRedirect("../login.jsp"); return; }
%>

<div class="container mt-5">
    <h2>My Service Requests</h2>
    <table class="table table-hover mt-4">
        <thead class="table-dark">
            <tr>
                <th>Title</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <%
                // Retrieve only requests posted by the logged-in customer
                ServiceRequestDAO dao = new ServiceRequestDAO();
                List<ServiceRequest> myRequests = dao.getRequestsByCustomerId(user.getUserId());
                for(ServiceRequest req : myRequests) {
            %>
            <tr>
                <td><%= req.getTitle() %></td>
                <td>
                    <span class="badge <%= req.getStatus().equals("Pending") ? "bg-warning" : "bg-success" %>">
                        <%= req.getStatus() %>
                    </span>
                </td>
                <td>
                    <a href="edit-request.jsp?id=<%= req.getRequestId() %>" class="btn btn-sm btn-primary">Edit</a>
                    <a href="../DeleteRequestServlet?id=<%= req.getRequestId() %>" class="btn btn-sm btn-danger">Delete</a>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>

<%@include file="../footer.jsp" %>