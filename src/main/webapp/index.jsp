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
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="header.jsp" %>
    <title>ServiceHub | Local Service & Job Marketplace</title>
    <!-- Custom visual enhancements -->
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%);
            --dark-gradient: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
            --accent-color: #f59e0b;
        }
        body {
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
            color: #334155;
            background-color: #f8fafc;
        }
        .hero-section {
            background: var(--dark-gradient);
            position: relative;
            overflow: hidden;
            padding: 100px 0;
        }
        .hero-section::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(59, 130, 246, 0.15) 0%, transparent 60%);
            pointer-events: none;
        }
        .section-title {
            position: relative;
            font-weight: 800;
            color: #0f172a;
            margin-bottom: 50px;
        }
        .section-title::after {
            content: '';
            position: absolute;
            left: 50%;
            bottom: -15px;
            transform: translateX(-50%);
            width: 60px;
            height: 4px;
            background: var(--primary-gradient);
            border-radius: 2px;
        }
        .service-card {
            border: none;
            border-radius: 16px;
            transition: all 0.3s ease;
            cursor: pointer;
            box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.05), 0 2px 4px -2px rgb(0 0 0 / 0.05);
            background: white;
            height: 100%;
        }
        .service-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);
            border-bottom: 4px solid #3b82f6;
        }
        .service-icon {
            font-size: 2.5rem;
            background: linear-gradient(135deg, #eff6ff 0%, #dbeafe 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 20px;
            display: inline-block;
        }
        .step-card {
            border: none;
            background: transparent;
            position: relative;
        }
        .step-number {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: var(--primary-gradient);
            color: white;
            font-weight: 700;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            box-shadow: 0 10px 15px -3px rgba(59, 130, 246, 0.4);
        }
        .stat-card {
            border: none;
            border-radius: 16px;
            background: white;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.05);
        }
        .testimonial-card {
            border: none;
            border-radius: 20px;
            background: white;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.05);
        }
        .faq-accordion .accordion-item {
            border: none;
            margin-bottom: 15px;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.05);
        }
        .faq-accordion .accordion-button {
            font-weight: 600;
            background-color: white;
        }
        .faq-accordion .accordion-button:not(.collapsed) {
            color: #2563eb;
            background-color: #eff6ff;
        }
    </style>
</head>
<body>

    <jsp:include page="common/navbar.jsp" />
    <%@ include file="chatbot.jsp" %>

    <!-- Hero Section -->
    <section class="hero-section text-white text-center py-5 d-flex align-items-center" style="min-height: 80vh;">
        <div class="container animate__animated animate__fadeIn">
            <h1 class="display-3 fw-extrabold mb-3">Find Local Services & <br><span class="text-info">Earn Money Nearby</span></h1>
            <p class="lead text-light-50 mb-5 mx-auto" style="max-width: 650px;">
                One platform, dual power. Request a service from certified local professionals, or accept open jobs nearby and boost your income anytime.
            </p>
            <div class="mt-4 gap-3 d-flex flex-wrap justify-content-center">
                <a href="login.jsp" class="btn btn-info btn-lg px-4 py-3 fw-bold shadow-lg me-sm-2 text-white">
                    <i class="fas fa-search me-2"></i>Find Jobs
                </a>
                <a href="login.jsp" class="btn btn-outline-light btn-lg px-4 py-3 fw-bold border-2">
                    <i class="fas fa-plus me-2"></i>Post Service Request
                </a>
            </div>
        </div>
    </section>

    <!-- Stats Counter Section -->
    <section class="py-5 bg-white border-bottom">
        <div class="container">
            <div class="row g-4 text-center">
                <div class="col-6 col-md-3" data-aos="fade-up" data-aos-delay="100">
                    <div class="stat-card p-4">
                        <h2 class="display-4 fw-bold text-primary">1,000+</h2>
                        <p class="text-muted fw-semibold mb-0">Completed Jobs</p>
                    </div>
                </div>
                <div class="col-6 col-md-3" data-aos="fade-up" data-aos-delay="200">
                    <div class="stat-card p-4">
                        <h2 class="display-4 fw-bold text-primary">500+</h2>
                        <p class="text-muted fw-semibold mb-0">Available Workers</p>
                    </div>
                </div>
                <div class="col-6 col-md-3" data-aos="fade-up" data-aos-delay="300">
                    <div class="stat-card p-4">
                        <h2 class="display-4 fw-bold text-primary">250+</h2>
                        <p class="text-muted fw-semibold mb-0">Active Customers</p>
                    </div>
                </div>
                <div class="col-6 col-md-3" data-aos="fade-up" data-aos-delay="400">
                    <div class="stat-card p-4">
                        <h2 class="display-4 fw-bold text-primary">4.9★</h2>
                        <p class="text-muted fw-semibold mb-0">Average Rating</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- How It Works Section -->
    <section id="how-it-works" class="py-5">
        <div class="container">
            <h2 class="section-title text-center" data-aos="fade-up">How ServiceHub Works</h2>
            <div class="row g-4 text-center mt-2">
                <div class="col-md-3 col-sm-6" data-aos="zoom-in" data-aos-delay="100">
                    <div class="step-card p-3">
                        <div class="step-number">1</div>
                        <h5 class="fw-bold">Create Account</h5>
                        <p class="text-muted">Register once to buy services or work locally.</p>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6" data-aos="zoom-in" data-aos-delay="200">
                    <div class="step-card p-3">
                        <div class="step-number">2</div>
                        <h5 class="fw-bold">Post Request</h5>
                        <p class="text-muted">Describe what you need, set budget & equipment requirements.</p>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6" data-aos="zoom-in" data-aos-delay="300">
                    <div class="step-card p-3">
                        <div class="step-number">3</div>
                        <h5 class="fw-bold">Workers Alerted</h5>
                        <p class="text-muted">Nearby workers receive notification & apply to your job request.</p>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6" data-aos="zoom-in" data-aos-delay="400">
                    <div class="step-card p-3">
                        <div class="step-number">4</div>
                        <h5 class="fw-bold">Approve & Earn</h5>
                        <p class="text-muted">Award the job, chat in real-time, complete task & get reviewed.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Services Grid Section -->
    <section id="services" class="py-5 bg-light">
        <div class="container">
            <h2 class="section-title text-center" data-aos="fade-up">Explore Available Services</h2>
            <p class="text-center text-muted mb-5 mx-auto" style="max-width: 600px;">
                Find trusted, verified professionals for various tasks or search for job postings in these categories:
            </p>
            <div class="row row-cols-2 row-cols-md-4 row-cols-lg-6 g-3">
                
                <!-- Service Cards -->
                <div class="col" data-aos="fade-up" data-aos-delay="50">
                    <div class="card service-card p-3 text-center">
                        <i class="fas fa-home service-icon text-primary"></i>
                        <h6 class="fw-bold text-dark">House Cleaning</h6>
                    </div>
                </div>
                <div class="col" data-aos="fade-up" data-aos-delay="100">
                    <div class="card service-card p-3 text-center">
                        <i class="fas fa-paint-roller service-icon"></i>
                        <h6 class="fw-bold text-dark">Painting</h6>
                    </div>
                </div>
                <div class="col" data-aos="fade-up" data-aos-delay="150">
                    <div class="card service-card p-3 text-center">
                        <i class="fas fa-tools service-icon"></i>
                        <h6 class="fw-bold text-dark">Home Renovation</h6>
                    </div>
                </div>
                <div class="col" data-aos="fade-up" data-aos-delay="200">
                    <div class="card service-card p-3 text-center">
                        <i class="fas fa-faucet service-icon"></i>
                        <h6 class="fw-bold text-dark">Plumbing</h6>
                    </div>
                </div>
                <div class="col" data-aos="fade-up" data-aos-delay="250">
                    <div class="card service-card p-3 text-center">
                        <i class="fas fa-bolt service-icon"></i>
                        <h6 class="fw-bold text-dark">Electrical Repair</h6>
                    </div>
                </div>
                <div class="col" data-aos="fade-up" data-aos-delay="300">
                    <div class="card service-card p-3 text-center">
                        <i class="fas fa-chair service-icon"></i>
                        <h6 class="fw-bold text-dark">Carpentry</h6>
                    </div>
                </div>
                <div class="col" data-aos="fade-up" data-aos-delay="350">
                    <div class="card service-card p-3 text-center">
                        <i class="fas fa-broom service-icon"></i>
                        <h6 class="fw-bold text-dark">Deep Cleaning</h6>
                    </div>
                </div>
                <div class="col" data-aos="fade-up" data-aos-delay="400">
                    <div class="card service-card p-3 text-center">
                        <i class="fas fa-paw service-icon"></i>
                        <h6 class="fw-bold text-dark">Pet Sitting</h6>
                    </div>
                </div>
                <div class="col" data-aos="fade-up" data-aos-delay="450">
                    <div class="card service-card p-3 text-center">
                        <i class="fas fa-car service-icon"></i>
                        <h6 class="fw-bold text-dark">Car Wash</h6>
                    </div>
                </div>
                <div class="col" data-aos="fade-up" data-aos-delay="500">
                    <div class="card service-card p-3 text-center">
                        <i class="fas fa-seedling service-icon"></i>
                        <h6 class="fw-bold text-dark">Gardening</h6>
                    </div>
                </div>
                <div class="col" data-aos="fade-up" data-aos-delay="550">
                    <div class="card service-card p-3 text-center">
                        <i class="fas fa-snowflake service-icon"></i>
                        <h6 class="fw-bold text-dark">AC Repair</h6>
                    </div>
                </div>
                <div class="col" data-aos="fade-up" data-aos-delay="600">
                    <div class="card service-card p-3 text-center">
                        <i class="fas fa-laptop service-icon"></i>
                        <h6 class="fw-bold text-dark">Computer Repair</h6>
                    </div>
                </div>
                <div class="col" data-aos="fade-up" data-aos-delay="650">
                    <div class="card service-card p-3 text-center">
                        <i class="fas fa-box service-icon"></i>
                        <h6 class="fw-bold text-dark">Moving Service</h6>
                    </div>
                </div>
                <div class="col" data-aos="fade-up" data-aos-delay="700">
                    <div class="card service-card p-3 text-center">
                        <i class="fas fa-baby service-icon"></i>
                        <h6 class="fw-bold text-dark">Baby Sitting</h6>
                    </div>
                </div>
                <div class="col" data-aos="fade-up" data-aos-delay="750">
                    <div class="card service-card p-3 text-center">
                        <i class="fas fa-blind service-icon"></i>
                        <h6 class="fw-bold text-dark">Elder Care</h6>
                    </div>
                </div>
                <div class="col" data-aos="fade-up" data-aos-delay="800">
                    <div class="card service-card p-3 text-center">
                        <i class="fas fa-book-reader service-icon"></i>
                        <h6 class="fw-bold text-dark">Home Tutoring</h6>
                    </div>
                </div>
                <div class="col" data-aos="fade-up" data-aos-delay="850">
                    <div class="card service-card p-3 text-center">
                        <i class="fas fa-utensils service-icon"></i>
                        <h6 class="fw-bold text-dark">Cooking Service</h6>
                    </div>
                </div>
                
            </div>
        </div>
    </section>

    <!-- Testimonials/Reviews -->
    <section id="reviews" class="py-5">
        <div class="container">
            <h2 class="section-title text-center" data-aos="fade-up">Trusted User Feedback</h2>
            <div class="row g-4 mt-3">
                <div class="col-md-4" data-aos="fade-right" data-aos-delay="100">
                    <div class="testimonial-card p-4">
                        <div class="d-flex align-items-center mb-3">
                            <img src="images/avatar-1.jpg" onerror="this.src='https://ui-avatars.com/api/?name=Kamal+Silva&background=eff6ff&color=2563eb'" class="rounded-circle me-3" width="50" height="50" alt="Avatar">
                            <div>
                                <h6 class="fw-bold mb-0">Kamal Silva</h6>
                                <small class="text-warning">★★★★★</small>
                            </div>
                        </div>
                        <p class="text-muted mb-0">"Excellent service! I booked a painter and he arrived in 30 minutes with his own ladder and paint rollers. Very professional."</p>
                    </div>
                </div>
                <div class="col-md-4" data-aos="fade-up" data-aos-delay="200">
                    <div class="testimonial-card p-4">
                        <div class="d-flex align-items-center mb-3">
                            <img src="images/avatar-2.jpg" onerror="this.src='https://ui-avatars.com/api/?name=Nilanthi+Perera&background=eff6ff&color=2563eb'" class="rounded-circle me-3" width="50" height="50" alt="Avatar">
                            <div>
                                <h6 class="fw-bold mb-0">Nilanthi Perera</h6>
                                <small class="text-warning">★★★★★</small>
                            </div>
                        </div>
                        <p class="text-muted mb-0">"As a part-time student, I use ServiceHub to pet-sit doggies during weekends in Bandarawela. It is a fantastic way to earn extra cash!"</p>
                    </div>
                </div>
                <div class="col-md-4" data-aos="fade-left" data-aos-delay="300">
                    <div class="testimonial-card p-4">
                        <div class="d-flex align-items-center mb-3">
                            <img src="images/avatar-3.jpg" onerror="this.src='https://ui-avatars.com/api/?name=John+D&background=eff6ff&color=2563eb'" class="rounded-circle me-3" width="50" height="50" alt="Avatar">
                            <div>
                                <h6 class="fw-bold mb-0">John D.</h6>
                                <small class="text-warning">★★★★★</small>
                            </div>
                        </div>
                        <p class="text-muted mb-0">"The nearby notification is spot on. As soon as I put a plumbing request, three local plumbers contacted me. Fast work!"</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- FAQ Accordion -->
    <section class="py-5 bg-light">
        <div class="container" style="max-width: 800px;">
            <h2 class="section-title text-center mb-5" data-aos="fade-up">Frequently Asked Questions</h2>
            <div class="accordion faq-accordion" id="faqAccordion" data-aos="fade-up">
                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#faq1">
                            Do I need separate accounts to request help and to work?
                        </button>
                    </h2>
                    <div id="faq1" class="accordion-collapse collapse show" data-bs-parent="#faqAccordion">
                        <div class="accordion-body">
                            No! You register once. You can post a job request or apply to jobs listed nearby from the exact same dashboard.
                        </div>
                    </div>
                </div>
                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq2">
                            How does the equipment agreement work?
                        </button>
                    </h2>
                    <div id="faq2" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                        <div class="accordion-body">
                            When posting a service request, you can select whether special equipment is needed. Workers will see this on the gig cards and can bid detailing if they have their own equipment or if they need you to provide it.
                        </div>
                    </div>
                </div>
                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq3">
                            How does the location search work?
                        </button>
                    </h2>
                    <div id="faq3" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                        <div class="accordion-body">
                            ServiceHub matches the GPS coordinates of the requester and nearby workers. Active available workers within a 10km radius receive instant alerts when a matching job is posted.
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Contact & Map Section -->
    <section id="contact" class="py-5 bg-dark text-white">
        <div class="container">
            <h2 class="section-title text-center text-white" data-aos="fade-up">Get in Touch</h2>
            <div class="row g-4 mt-3">
                <div class="col-md-5" data-aos="fade-right">
                    <h5>ServiceHub Support</h5>
                    <p class="text-light-50 mt-3">We are here to assist local workers and customers. Reach out to us if you need help with payments, verification, or usage.</p>
                    <p class="mt-4"><strong><i class="fas fa-envelope text-info me-2"></i>Email:</strong> support@servicehub.lk</p>
                    <p><strong><i class="fas fa-phone text-info me-2"></i>Phone:</strong> +94 57 222 3344</p>
                    <p><strong><i class="fas fa-map-marker-alt text-info me-2"></i>HQ Address:</strong> Badulla Road, Bandarawela, Sri Lanka.</p>
                </div>
                <div class="col-md-7" data-aos="fade-left">
                    <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d15830.457850877964!2d80.98595567702813!3d6.82959779374163!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3ae3871146c927f9%3A0x6a2c2c0693a0b81c!2sBandarawela!5e0!3m2!1sen!2slk!4v1689050000000!5m2!1sen!2slk" width="100%" height="280" style="border:0; border-radius: 12px;" allowfullscreen="" loading="lazy"></iframe>
                </div>
            </div>
        </div>
    </section>

    <footer class="text-center py-4 bg-dark text-white border-top border-secondary">
        <div class="container">
            <p class="mb-2">© 2026 ServiceHub | Connecting Local Talents</p>
            <div class="fs-5 gap-3 d-flex justify-content-center text-muted">
                <a href="#" class="text-white-50"><i class="fab fa-facebook"></i></a>
                <a href="#" class="text-white-50"><i class="fab fa-instagram"></i></a>
                <a href="#" class="text-white-50"><i class="fab fa-linkedin"></i></a>
            </div>
        </div>
    </footer>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>
        AOS.init({
            duration: 800,
            once: true
        });
    </script>
</body>
</html>