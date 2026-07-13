<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.servicehub.dao.ReportDAO, java.util.Map"%>
<%
    ReportDAO reportDAO = new ReportDAO();
    Map<String, Integer> stats = reportDAO.getSystemStats();
    request.setAttribute("stats", stats);
%>
<!DOCTYPE html>
<html>
<head>
    <title>System Reports - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h3 class="mb-4">System Statistics Report</h3>
    
    <div class="row text-center">
        <div class="col-md-3"><div class="card p-3 shadow-sm bg-primary text-white"><h5>Users</h5><h3>${stats.users}</h3></div></div>
        <div class="col-md-3"><div class="card p-3 shadow-sm bg-success text-white"><h5>Bookings</h5><h3>${stats.bookings}</h3></div></div>
        <div class="col-md-3"><div class="card p-3 shadow-sm bg-warning"><h5>Services</h5><h3>${stats.services}</h3></div></div>
        <div class="col-md-3"><div class="card p-3 shadow-sm bg-info text-white"><h5>Reviews</h5><h3>${stats.reviews}</h3></div></div>
    </div>

    <div class="mt-5 p-4 bg-white shadow-sm">
        <h5>Export Data</h5>
        <hr>
        <button class="btn btn-danger" onclick="window.print()">Export as PDF</button>
        <button class="btn btn-success" onclick="alert('Excel export functionality to be integrated with Apache POI')">Export as Excel</button>
    </div>
</div>
</body>
</html>