<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>System Settings</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="card p-4 shadow-sm" style="max-width: 600px; margin: auto;">
        <h3 class="mb-4">System Settings</h3>
        <form action="../SettingsServlet" method="POST">
            <div class="mb-3">
                <label>Website Name</label>
                <input type="text" name="websiteName" class="form-control" required>
            </div>
            <div class="mb-3">
                <label>Contact Email</label>
                <input type="email" name="contactEmail" class="form-control">
            </div>
            <div class="mb-3">
                <label>Maintenance Mode</label>
                <select name="maintenanceMode" class="form-control">
                    <option value="false">Disabled</option>
                    <option value="true">Enabled</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary w-100">Save Changes</button>
        </form>
    </div>
</div>
</body>
</html>