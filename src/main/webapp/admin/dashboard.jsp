<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="com.mycompany.servicehub.dao.NotificationDAO"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - ServiceHub</title>
    <%@include file="../header.jsp" %>
    <style>
        .stat-card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.03);
            background: #ffffff;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.08);
        }
        .stat-icon {
            font-size: 2rem;
            opacity: 0.8;
        }
    </style>
</head>
<body>

    <jsp:include page="../common/sidebar.jsp" />

    <div class="main-content">
        <h2 class="mb-4 fw-bold">Admin Dashboard</h2>
        
        <div class="row g-4 mb-5">
            <!-- Total Users -->
            <div class="col-md-6 col-lg-4">
                <div class="card stat-card p-3 border-start border-primary border-4">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <p class="text-muted small fw-semibold mb-1">Total Users</p>
                            <h3 class="fw-bold mb-0">${not empty totalUsers ? totalUsers : 0}</h3>
                        </div>
                        <i class="fas fa-users text-primary stat-icon"></i>
                    </div>
                </div>
            </div>
            
            <!-- Service Requests -->
            <div class="col-md-6 col-lg-4">
                <div class="card stat-card p-3 border-start border-info border-4">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <p class="text-muted small fw-semibold mb-1">Total Service Requests</p>
                            <h3 class="fw-bold mb-0">${not empty totalRequests ? totalRequests : 0}</h3>
                        </div>
                        <i class="fas fa-file-alt text-info stat-icon"></i>
                    </div>
                </div>
            </div>

            <!-- Total Reviews -->
            <div class="col-md-6 col-lg-4">
                <div class="card stat-card p-3 border-start border-warning border-4">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <p class="text-muted small fw-semibold mb-1">Total Reviews</p>
                            <h3 class="fw-bold mb-0">${not empty totalReviews ? totalReviews : 0}</h3>
                        </div>
                        <i class="fas fa-star text-warning stat-icon"></i>
                    </div>
                </div>
            </div>

            <!-- Active Bookings -->
            <div class="col-md-6 col-lg-4">
                <div class="card stat-card p-3 border-start border-success border-4">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <p class="text-muted small fw-semibold mb-1">Active Bookings</p>
                            <h3 class="fw-bold mb-0">${not empty activeBookings ? activeBookings : 0}</h3>
                        </div>
                        <i class="fas fa-calendar-check text-success stat-icon"></i>
                    </div>
                </div>
            </div>

            <!-- Completed Jobs -->
            <div class="col-md-6 col-lg-4">
                <div class="card stat-card p-3 border-start border-secondary border-4">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <p class="text-muted small fw-semibold mb-1">Completed Jobs</p>
                            <h3 class="fw-bold mb-0">${not empty completedJobs ? completedJobs : 0}</h3>
                        </div>
                        <i class="fas fa-check-circle text-secondary stat-icon"></i>
                    </div>
                </div>
            </div>

            <!-- Pending Requests -->
            <div class="col-md-6 col-lg-4">
                <div class="card stat-card p-3 border-start border-danger border-4">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <p class="text-muted small fw-semibold mb-1">Pending Requests</p>
                            <h3 class="fw-bold mb-0">${not empty pendingRequests ? pendingRequests : 0}</h3>
                        </div>
                        <i class="fas fa-clock text-danger stat-icon"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="card shadow-sm mb-4 bg-white p-4">
            <h5 class="fw-bold mb-3"><i class="fas fa-bell me-2 text-primary"></i>Recent Activities</h5>
            <ul class="list-group list-group-flush">
                <% 
                    NotificationDAO nDao = new NotificationDAO();
                    List<String> notes = nDao.getRecentNotifications();
                    
                    if (notes == null || notes.isEmpty()) {
                %>
                    <li class="list-group-item text-muted">No new activities.</li>
                <% 
                    } else {
                        for (String note : notes) {
                %>
                    <li class="list-group-item">
                        <i class="fas fa-bell text-primary me-2"></i> <%= note %>
                    </li>
                <% 
                        }
                    }
                %>
            </ul>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>