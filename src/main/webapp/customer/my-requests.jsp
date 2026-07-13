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

<jsp:include page="../common/sidebar.jsp" />

<div class="main-content">
    <div class="container-fluid">
        <h2 class="fw-bold text-dark mb-4">My Service Requests</h2>
        <div class="card p-3 shadow-sm border-0 bg-white">
            <div class="table-responsive">
                <table class="table table-hover mt-2 align-middle">
                    <thead class="table-light">
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
                            if (myRequests != null && !myRequests.isEmpty()) {
                                for(ServiceRequest req : myRequests) {
                        %>
                        <tr>
                            <td><strong><%= req.getTitle() %></strong></td>
                            <td>
                                <span class="badge <%= req.getStatus().equals("Pending") ? "bg-warning" : "bg-success" %> px-3 py-2 rounded-pill fw-semibold">
                                    <%= req.getStatus() %>
                                </span>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/customer/my-bookings.jsp" class="btn btn-sm btn-outline-primary fw-semibold">Manage Booking</a>
                            </td>
                        </tr>
                        <% } } else { %>
                            <tr>
                                <td colspan="3" class="text-center py-4 text-muted">No service requests found.</td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<%@include file="../footer.jsp" %>