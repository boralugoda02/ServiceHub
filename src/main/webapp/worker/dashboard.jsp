<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Worker Dashboard - ServiceHub</title>
    <%@include file="../header.jsp" %>
</head>
<body>

    <jsp:include page="../common/sidebar.jsp" />

    <div class="main-content">
        <h2 class="mb-4 fw-bold">Worker Dashboard</h2>
        
        <c:if test="${not empty param.msg}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                Status updated successfully!
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <div class="row g-4">
            <div class="col-md-6 col-lg-4">
                <div class="card p-4 shadow-sm bg-white">
                    <h5 class="fw-bold mb-3">Update Your Availability</h5>
                    
                    <form action="../UpdateStatusServlet" method="POST">
                        <div class="mb-3">
                            <label class="form-label text-muted small fw-semibold">Current Status:</label>
                            <select name="status" class="form-select">
                                <option value="Available" ${sessionScope.userStatus == 'Available' ? 'selected' : ''}>Available</option>
                                <option value="Busy" ${sessionScope.userStatus == 'Busy' ? 'selected' : ''}>Busy</option>
                                <option value="Offline" ${sessionScope.userStatus == 'Offline' ? 'selected' : ''}>Offline</option>
                            </select>
                        </div>
                        
                        <button type="submit" class="btn btn-primary w-100 fw-semibold">
                            Update Status
                        </button>
                    </form>
                </div>
            </div>
            
            <div class="col-md-6 col-lg-8">
                <div class="card p-4 shadow-sm bg-white h-100">
                    <h5 class="fw-bold mb-2">Welcome to Your Gigs Center</h5>
                    <p class="text-muted">Set your status to <strong class="text-success">Available</strong> to receive job match notifications nearby. Check your gigs list in the sidebar to manage accepted requests.</p>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>