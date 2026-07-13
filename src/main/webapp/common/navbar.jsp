<%-- common/navbar.jsp --%>
<nav class="navbar navbar-expand-lg sticky-top shadow-sm bg-white">
    <div class="container">
        <a class="navbar-brand fw-bold text-primary" href="${pageContext.request.contextPath}/index.jsp">ServiceHub</a>
        
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navContent">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navContent">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/index.jsp#services">Services</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/index.jsp#about">About</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/index.jsp#how-it-works">How It Works</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/index.jsp#reviews">Reviews</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/index.jsp#contact">Contact</a></li>
            </ul>
            
            <div class="d-flex">
                <a class="btn btn-outline-primary me-2" href="${pageContext.request.contextPath}/login.jsp">Login</a>
                <a class="btn btn-primary" href="${pageContext.request.contextPath}/register.jsp">Register</a>
            </div>
        </div>
    </div>
</nav>