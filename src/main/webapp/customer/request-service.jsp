<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Request Service - ServiceHub</title>
    <link rel="stylesheet" href="../css/style.css">
    
    <script>
        // Automatically set the minimum date to today to prevent past date selection
        window.onload = function() {
            var today = new Date().toISOString().split('T')[0];
            document.getElementById("serviceDate").setAttribute('min', today);
            getLocation();
        };

        // Capture user's current GPS location
        function getLocation() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function(position) {
                    document.getElementById("latitude").value = position.coords.latitude;
                    document.getElementById("longitude").value = position.coords.longitude;
                });
            }
        }

        // Toggle visibility of equipment list
        function toggleEquipmentList() {
            var select = document.getElementById("equipSelect");
            var div = document.getElementById("equipmentListDiv");
            div.style.display = (select.value === "Yes") ? "block" : "none";
        }
    </script>
</head>
<body>
    <div class="container">
        <h2>Request a Service</h2>
        <form action="../BookingServlet" method="POST">
            <input type="hidden" name="action" value="create">
            <input type="hidden" name="workerId" value="${param.workerId}">
            <input type="hidden" name="requestId" value="${param.requestId}">

            <div class="form-group">
                <label>District:</label>
                <input type="text" name="district" class="form-control" required>
            </div>
            <div class="form-group">
                <label>City:</label>
                <input type="text" name="city" class="form-control" required>
            </div>
            <div class="form-group">
                <label>Address:</label>
                <input type="text" name="address" class="form-control" required>
            </div>
            <input type="hidden" name="latitude" id="latitude">
            <input type="hidden" name="longitude" id="longitude">

            <div class="form-group">
                <label>Service Date:</label>
                <input type="date" name="serviceDate" id="serviceDate" class="form-control" required>
            </div>
            <div class="form-group">
                <label>Service Time:</label>
                <input type="time" name="serviceTime" class="form-control" required>
            </div>
            <div class="form-group">
                <label>Duration (Hours):</label>
                <input type="number" name="duration" min="1" max="12" class="form-control" required>
            </div>

            <div class="form-group">
                <label>Do you have the necessary equipment?</label>
                <select name="equipmentAvailable" id="equipSelect" onchange="toggleEquipmentList()" class="form-control">
                    <option value="No">No</option>
                    <option value="Yes">Yes</option>
                </select>
            </div>

            <div id="equipmentListDiv" class="form-group" style="display:none;">
                <label>Select Equipment you provide:</label><br>
                <input type="checkbox" name="equipmentList" value="Drill Machine"> Drill Machine<br>
                <input type="checkbox" name="equipmentList" value="Ladder"> Ladder<br>
                <input type="checkbox" name="equipmentList" value="Tool Kit"> Tool Kit
            </div>

            <button type="submit" class="btn btn-primary">Submit Booking</button>
        </form>
    </div>
</body>
</html>