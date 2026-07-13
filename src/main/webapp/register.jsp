<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.servicehub.model.User"%>
<%
    // If the user is ALREADY logged in, redirect them to dashboard
    User user = (User) session.getAttribute("user");
    if (user != null) {
        response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="header.jsp" %>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    <title>Register | ServiceHub</title>
    <script>
        function validateForm() {
            let phone = document.forms["regForm"]["phoneNumber"].value;
            let email = document.forms["regForm"]["email"].value;
            let nic = document.forms["regForm"]["nic"].value;
            let password = document.forms["regForm"]["password"].value;
            let confirmPassword = document.forms["regForm"]["confirmPassword"].value;

            // Validate Phone: Must be exactly 10 digits
            let phonePattern = /^\d{10}$/;
            if (!phonePattern.test(phone)) {
                alert("Phone number must be exactly 10 digits.");
                return false;
            }

            // Validate Email: Standard format
            let emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailPattern.test(email)) {
                alert("Invalid email format.");
                return false;
            }

            // Validate NIC: 10 or 12 characters
            let nicPattern = /^([0-9]{9}[vVxX]|[0-9]{12})$/;
            if (!nicPattern.test(nic)) {
                alert("Invalid NIC format.");
                return false;
            }

            // Confirm password check
            if (password !== confirmPassword) {
                alert("Passwords do not match.");
                return false;
            }

            return true;
        }

        function toggleWorkerFields() {
            let role = document.getElementById("roleSelect").value;
            let workerFields = document.getElementById("workerFields");
            if (role === "Worker") {
                workerFields.style.display = "block";
            } else {
                workerFields.style.display = "none";
            }
        }
    </script>
</head>
<body class="login-body">
    <div class="card login-card shadow-lg my-5" data-aos="zoom-in" data-aos-duration="600" style="max-width: 500px;">
        <h3 class="text-center mb-4 fw-bold">Create Account</h3>

        <form name="regForm" action="register" method="POST" onsubmit="return validateForm()">
            <div class="mb-3">
                <label class="form-label">Full Name</label>
                <input type="text" name="fullName" class="form-control" placeholder="Enter full name" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Email Address</label>
                <input type="email" name="email" class="form-control" placeholder="name@example.com" required>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Phone Number</label>
                    <input type="text" name="phoneNumber" class="form-control" placeholder="e.g. 0771234567" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">NIC Number</label>
                    <input type="text" name="nic" class="form-control" placeholder="e.g. 199912345678" required>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label">Account Role</label>
                <select name="role" id="roleSelect" class="form-control text-white" onchange="toggleWorkerFields()" style="background-color: rgba(15, 23, 42, 0.8);" required>
                    <option value="Customer" class="text-dark">Customer (Hire Professionals)</option>
                    <option value="Worker" class="text-dark">Worker (Provide Services)</option>
                </select>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">District</label>
                    <input type="text" name="district" class="form-control" placeholder="e.g. Colombo" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">City</label>
                    <input type="text" name="city" class="form-control" placeholder="e.g. Maharagama" required>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label">Full Address</label>
                <input type="text" name="address" class="form-control" placeholder="Street address, block number" required>
            </div>

            <!-- Worker Specific Fields (Hidden by default) -->
            <div id="workerFields" style="display: none;">
                <div class="mb-3">
                    <label class="form-label">Special Skills / Services</label>
                    <input type="text" name="skills" class="form-control" placeholder="e.g. Plumbing, Electrician, Carpentry">
                </div>
                <div class="mb-3">
                    <label class="form-label">Own Equipment Details</label>
                    <input type="text" name="equipment" class="form-control" placeholder="e.g. Toolbox, Ladder, Drills">
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Password</label>
                    <input type="password" name="password" class="form-control" placeholder="At least 6 chars" required minlength="6">
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Confirm Password</label>
                    <input type="password" name="confirmPassword" class="form-control" placeholder="Repeat password" required minlength="6">
                </div>
            </div>

            <button type="submit" class="btn btn-primary w-100 mt-3 fw-bold">Register Now</button>
        </form>

        <div class="text-center mt-4">
            <p class="mb-0">Already have an account? <a href="login.jsp">Login here</a></p>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>
        AOS.init();
    </script>
</body>
</html>