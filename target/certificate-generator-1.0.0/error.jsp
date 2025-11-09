<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - Certificate Generator</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="fas fa-certificate"></i> Certificate Generator
            </a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="${pageContext.request.contextPath}/">Home</a>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card border-danger">
                    <div class="card-header bg-danger text-white text-center">
                        <h3><i class="fas fa-exclamation-triangle"></i> Error</h3>
                    </div>
                    <div class="card-body text-center">
                        <i class="fas fa-times-circle fa-4x text-danger mb-3"></i>
                        
                        <c:choose>
                            <c:when test="${not empty error}">
                                <h5>An error occurred:</h5>
                                <p class="text-danger">${error}</p>
                            </c:when>
                            <c:otherwise>
                                <h5>Something went wrong</h5>
                                <p class="text-muted">We're sorry, but an unexpected error occurred. Please try again later.</p>
                            </c:otherwise>
                        </c:choose>

                        <div class="mt-4">
                            <a href="${pageContext.request.contextPath}/" class="btn btn-primary me-2">
                                <i class="fas fa-home"></i> Go Home
                            </a>
                            <button onclick="history.back()" class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i> Go Back
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>