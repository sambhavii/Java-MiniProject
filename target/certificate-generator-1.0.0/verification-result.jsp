<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verification Result - Certificate Generator</title>
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
                <a class="nav-link" href="${pageContext.request.contextPath}/verify">Verify Another</a>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <c:choose>
                    <c:when test="${isValid}">
                        <!-- Valid Certificate -->
                        <div class="card border-success">
                            <div class="card-header bg-success text-white text-center">
                                <h3><i class="fas fa-check-circle"></i> Certificate Verified</h3>
                            </div>
                            <div class="card-body">
                                <div class="alert alert-success" role="alert">
                                    <i class="fas fa-shield-alt"></i> This certificate is <strong>VALID</strong> and authentic.
                                </div>

                                <div class="row">
                                    <div class="col-md-6">
                                        <h5>Certificate Details:</h5>
                                        <table class="table table-borderless">
                                            <tr>
                                                <td><strong>Certificate ID:</strong></td>
                                                <td>${certificate.certificateId}</td>
                                            </tr>
                                            <tr>
                                                <td><strong>Student Name:</strong></td>
                                                <td>${certificate.studentName}</td>
                                            </tr>
                                            <tr>
                                                <td><strong>Course:</strong></td>
                                                <td>${certificate.course}</td>
                                            </tr>
                                            <tr>
                                                <td><strong>Grade:</strong></td>
                                                <td>${certificate.grade}</td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="col-md-6">
                                        <h5>Issuance Information:</h5>
                                        <table class="table table-borderless">
                                            <tr>
                                                <td><strong>Institution:</strong></td>
                                                <td>${certificate.institutionName}</td>
                                            </tr>
                                            <tr>
                                                <td><strong>Issue Date:</strong></td>
                                                <td>${certificate.issueDate}</td>
                                            </tr>
                                            <tr>
                                                <td><strong>Template:</strong></td>
                                                <td>${certificate.templateType}</td>
                                            </tr>
                                            <tr>
                                                <td><strong>Status:</strong></td>
                                                <td><span class="badge bg-success">${certificate.status}</span></td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>

                                <div class="row mt-3">
                                    <div class="col-12">
                                        <h5>Digital Signature:</h5>
                                        <p class="font-monospace text-muted">${certificate.digitalSignature}</p>
                                    </div>
                                </div>

                                <div class="text-center mt-4">
                                    <a href="${pageContext.request.contextPath}/certificate/view/${certificate.certificateId}" 
                                       class="btn btn-primary me-2">
                                        <i class="fas fa-eye"></i> View Full Certificate
                                    </a>
                                    <a href="${pageContext.request.contextPath}/pdf/download/${certificate.certificateId}" 
                                       class="btn btn-danger">
                                        <i class="fas fa-file-pdf"></i> Download PDF
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- Invalid Certificate -->
                        <div class="card border-danger">
                            <div class="card-header bg-danger text-white text-center">
                                <h3><i class="fas fa-times-circle"></i> Certificate Not Valid</h3>
                            </div>
                            <div class="card-body">
                                <c:choose>
                                    <c:when test="${not empty certificate}">
                                        <!-- Certificate exists but not active -->
                                        <div class="alert alert-warning" role="alert">
                                            <i class="fas fa-exclamation-triangle"></i> 
                                            Certificate found but ${statusMessage}
                                        </div>

                                        <div class="row">
                                            <div class="col-md-6">
                                                <h5>Certificate Details:</h5>
                                                <table class="table table-borderless">
                                                    <tr>
                                                        <td><strong>Certificate ID:</strong></td>
                                                        <td>${certificate.certificateId}</td>
                                                    </tr>
                                                    <tr>
                                                        <td><strong>Student Name:</strong></td>
                                                        <td>${certificate.studentName}</td>
                                                    </tr>
                                                    <tr>
                                                        <td><strong>Course:</strong></td>
                                                        <td>${certificate.course}</td>
                                                    </tr>
                                                    <tr>
                                                        <td><strong>Status:</strong></td>
                                                        <td><span class="badge bg-warning">${certificate.status}</span></td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div class="col-md-6">
                                                <h5>Issuance Information:</h5>
                                                <table class="table table-borderless">
                                                    <tr>
                                                        <td><strong>Institution:</strong></td>
                                                        <td>${certificate.institutionName}</td>
                                                    </tr>
                                                    <tr>
                                                        <td><strong>Issue Date:</strong></td>
                                                        <td>${certificate.issueDate}</td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- Certificate not found -->
                                        <div class="alert alert-danger" role="alert">
                                            <i class="fas fa-times-circle"></i> 
                                            ${errorMessage}
                                        </div>
                                        
                                        <div class="text-center">
                                            <i class="fas fa-search fa-4x text-muted mb-3"></i>
                                            <p class="text-muted">
                                                The certificate ID you entered could not be found in our records. 
                                                Please check the ID and try again.
                                            </p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>

                <!-- Action Buttons -->
                <div class="text-center mt-4">
                    <a href="${pageContext.request.contextPath}/verify" class="btn btn-outline-primary me-2">
                        <i class="fas fa-search"></i> Verify Another Certificate
                    </a>
                    <a href="${pageContext.request.contextPath}/" class="btn btn-outline-secondary">
                        <i class="fas fa-home"></i> Back to Home
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>