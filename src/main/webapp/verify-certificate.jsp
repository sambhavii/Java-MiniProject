<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verify Certificate - Certificate Generator</title>
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
                <a class="nav-link" href="${pageContext.request.contextPath}/certificate/">Create Certificate</a>
                <a class="nav-link active" href="${pageContext.request.contextPath}/verify">Verify Certificate</a>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header text-center">
                        <h3><i class="fas fa-search"></i> Certificate Verification</h3>
                    </div>
                    <div class="card-body">
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger" role="alert">
                                <i class="fas fa-exclamation-triangle"></i> ${error}
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/verify" method="post">
                            <div class="mb-3">
                                <label for="certificateId" class="form-label">Certificate ID</label>
                                <input type="text" class="form-control" id="certificateId" name="certificateId" 
                                       placeholder="Enter Certificate ID (e.g., CERT-1234567890-123)" required>
                                <div class="form-text">
                                    Enter the unique certificate ID to verify its authenticity.
                                </div>
                            </div>

                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary btn-lg">
                                    <i class="fas fa-check-circle"></i> Verify Certificate
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- QR Code Scanner Info -->
                <div class="card mt-4">
                    <div class="card-header">
                        <h5><i class="fas fa-qrcode"></i> QR Code Verification</h5>
                    </div>
                    <div class="card-body">
                        <p class="text-muted">
                            You can also verify certificates by scanning the QR code on the certificate. 
                            The QR code will automatically redirect you to the verification page.
                        </p>
                        <div class="text-center">
                            <i class="fas fa-mobile-alt fa-3x text-primary mb-2"></i>
                            <p class="small">Use your mobile device to scan QR codes</p>
                        </div>
                    </div>
                </div>

                <!-- API Information -->
                <div class="card mt-4">
                    <div class="card-header">
                        <h5><i class="fas fa-code"></i> API Verification</h5>
                    </div>
                    <div class="card-body">
                        <p class="text-muted">For programmatic verification, use our API endpoint:</p>
                        <code>GET ${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/verify?id=CERTIFICATE_ID&format=json</code>
                        <p class="small mt-2">Returns JSON response with verification status and certificate details.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>