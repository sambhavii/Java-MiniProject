<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Certificate Generator System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .hero-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 100px 0;
        }
        .feature-card {
            transition: transform 0.3s;
            border: none;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        .feature-card:hover {
            transform: translateY(-5px);
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="fas fa-certificate"></i> Certificate Generator
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/certificate/">Create Certificate</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/verify">Verify Certificate</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">Admin Dashboard</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-section text-center">
        <div class="container">
            <h1 class="display-4 mb-4">Digital Certificate Generator</h1>
            <p class="lead mb-5">Create, manage, and verify digital certificates with QR code authentication</p>
            <div class="row">
                <div class="col-md-4 mb-3">
                    <a href="${pageContext.request.contextPath}/certificate/" class="btn btn-light btn-lg">
                        <i class="fas fa-plus-circle"></i> Create Certificate
                    </a>
                </div>
                <div class="col-md-4 mb-3">
                    <a href="${pageContext.request.contextPath}/verify" class="btn btn-outline-light btn-lg">
                        <i class="fas fa-search"></i> Verify Certificate
                    </a>
                </div>
                <div class="col-md-4 mb-3">
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-outline-light btn-lg">
                        <i class="fas fa-tachometer-alt"></i> Admin Panel
                    </a>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="py-5">
        <div class="container">
            <h2 class="text-center mb-5">Key Features</h2>
            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="card feature-card h-100">
                        <div class="card-body text-center">
                            <i class="fas fa-certificate fa-3x text-primary mb-3"></i>
                            <h5 class="card-title">Multiple Templates</h5>
                            <p class="card-text">Choose from various certificate templates including Course Completion, Participation, and Excellence awards.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card feature-card h-100">
                        <div class="card-body text-center">
                            <i class="fas fa-qrcode fa-3x text-success mb-3"></i>
                            <h5 class="card-title">QR Code Verification</h5>
                            <p class="card-text">Each certificate includes a unique QR code for instant verification and authenticity checking.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card feature-card h-100">
                        <div class="card-body text-center">
                            <i class="fas fa-users fa-3x text-warning mb-3"></i>
                            <h5 class="card-title">Bulk Generation</h5>
                            <p class="card-text">Create multiple certificates at once for events, courses, or batch processing.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card feature-card h-100">
                        <div class="card-body text-center">
                            <i class="fas fa-file-pdf fa-3x text-danger mb-3"></i>
                            <h5 class="card-title">PDF Download</h5>
                            <p class="card-text">Download certificates as high-quality PDF files for printing or digital sharing.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card feature-card h-100">
                        <div class="card-body text-center">
                            <i class="fas fa-shield-alt fa-3x text-info mb-3"></i>
                            <h5 class="card-title">Digital Security</h5>
                            <p class="card-text">Secure certificates with digital signatures and tamper-proof XML record keeping.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card feature-card h-100">
                        <div class="card-body text-center">
                            <i class="fas fa-chart-bar fa-3x text-secondary mb-3"></i>
                            <h5 class="card-title">Admin Dashboard</h5>
                            <p class="card-text">Comprehensive admin panel to track, manage, and control all issued certificates.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-dark text-light py-4">
        <div class="container text-center">
            <p>&copy; 2024 Certificate Generator System. All rights reserved.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>