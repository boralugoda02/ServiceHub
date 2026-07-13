<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.servicehub.dao.AnalyticsDAO, java.util.Map"%>
<%
    AnalyticsDAO analyticsDAO = new AnalyticsDAO();
    Map<String, Object> data = analyticsDAO.getAnalyticsData();
    request.setAttribute("data", data);
%>
<!DOCTYPE html>
<html>
<head>
    <title>Analytics Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body class="bg-light">
<div class="container mt-5">
    <h3 class="mb-4">Analytics Dashboard</h3>
    
    <div class="row text-center mb-5">
        <div class="col-md-3"><div class="card p-3 shadow-sm"><h6>Daily Users</h6><h3>${data.dailyUsers}</h3></div></div>
        <div class="col-md-3"><div class="card p-3 shadow-sm"><h6>Monthly Bookings</h6><h3>${data.monthlyBookings}</h3></div></div>
        <div class="col-md-3"><div class="card p-3 shadow-sm"><h6>Top Service</h6><h5>${data.topService}</h5></div></div>
        <div class="col-md-3"><div class="card p-3 shadow-sm"><h6>Active Users</h6><h3>${data.activeUsers}</h3></div></div>
    </div>

    <div class="bg-white p-4 shadow-sm">
        <canvas id="analyticsChart" height="100"></canvas>
    </div>
</div>

<script>
    const ctx = document.getElementById('analyticsChart').getContext('2d');
    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['Daily Users', 'Monthly Bookings', 'Active Users'],
            datasets: [{
                label: 'System Analytics',
                data: [${data.dailyUsers}, ${data.monthlyBookings}, ${data.activeUsers}],
                backgroundColor: ['#0d6efd', '#198754', '#0dcaf0']
            }]
        }
    });
</script>
</body>
</html>