<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.servicehub.model.User"%>
<%
    // If the user is ALREADY logged in, send them to the dashboard instead
    // of showing the registration form again.
    User user = (User) session.getAttribute("user");
    if (user != null) {
        response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
        return;
    }
%>
<html>
<head>
    <title>Registration</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <script>
        // Function to validate the form inputs before submission
        function validateForm() {
            // Get form values
            let phone = document.forms["regForm"]["phoneNumber"].value;
            let email = document.forms["regForm"]["email"].value;
            let nic = document.forms["regForm"]["nic"].value;

            // Validate Phone: Must be exactly 10 digits
            let phonePattern = /^\d{10}$/;
            if (!phonePattern.test(phone)) {
                alert("Phone number must be exactly 10 digits.");
                return false; // Stop form submission
            }

            // Validate Email: Standard regex format
            let emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailPattern.test(email)) {
                alert("Invalid email format.");
                return false; // Stop form submission
            }

            // Validate NIC: Basic check for 10 or 12 digits
            let nicPattern = /^([0-9]{9}[vVxX]|[0-9]{12})$/;
            if (!nicPattern.test(nic)) {
                alert("Invalid NIC format.");
                return false; // Stop form submission
            }

            return true; // Form is valid, proceed to submit
        }
    </script>
</head>
<body>
    <div class="container mt-5">
        <h2>Register Here</h2>
        <form name="regForm" action="register" method="POST" onsubmit="return validateForm()">

            <div class="mb-3">
                <label>Full Name</label>
                <input type="text" name="fullName" class="form-control" required>
            </div>

            <div class="mb-3">
                <label>Email</label>
                <input type="text" name="email" class="form-control" required>
            </div>

            <div class="mb-3">
                <label>Phone Number</label>
                <input type="text" name="phoneNumber" class="form-control" required>
            </div>

            <div class="mb-3">
                <label>NIC</label>
                <input type="text" name="nic" class="form-control" required>
            </div>

            <div class="mb-3">
                <label>Password</label>
                <input type="password" name="password" class="form-control" required minlength="6">
            </div>

            <div class="mb-3">
                <label>Confirm Password</label>
                <input type="password" name="confirmPassword" class="form-control" required minlength="6">
            </div>

            <button type="submit" class="btn btn-primary">Register</button>
        </form>
    </div>
</body>
</html>