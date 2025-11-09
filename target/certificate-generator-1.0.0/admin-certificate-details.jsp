<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Certificate Management - ${certificate.certificateId}</title>
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
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/certificates">All Certificates</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2><i class="fas fa-cog"></i> Certificate Management</h2>
                    <a href="${pageContext.request.contextPath}/admin/certificates" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Back to List
                    </a>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">
                        <i class="fas fa-exclamation-triangle"></i> ${error}
                    </div>
                </c:if>

                <c:if test="${not empty message}">
                    <div class="alert alert-success" role="alert">
                        <i class="fas fa-check-circle"></i> ${message}
                    </div>
                </c:if>

                <!-- Certificate Information -->
                <div class="row">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">
                                <h5><i class="fas fa-info-circle"></i> Certificate Details</h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <table class="table table-borderless">
                                            <tr>
                                                <td><strong>Certificate ID:</strong></td>
                                                <td><code>${certificate.certificateId}</code></td>
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
                                        <table class="table table-borderless">
                                            <tr>
                                                <td><strong>Institution:</strong></td>
                                                <td>${certificate.institutionName}</td>
                                            </tr>
                                            <tr>
                                                <td><strong>Template:</strong></td>
                                                <td>${certificate.templateType}</td>
                                            </tr>
                                            <tr>
                                                <td><strong>Issue Date:</strong></td>
                                                <td>${certificate.issueDate}</td>
                                            </tr>
                                            <tr>
                                                <td><strong>Status:</strong></td>
                                                <td>
                                                    <span class="badge ${certificate.status == 'ACTIVE' ? 'bg-success' : certificate.status == 'REVOKED' ? 'bg-danger' : 'bg-warning'}">
                                                        ${certificate.status}
                                                    </span>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <div class="col-12">
                                        <hr>
                                        <p><strong>Digital Signature:</strong></p>
                                        <code class="small">${certificate.digitalSignature}</code>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Quick Actions -->
                        <div class="card mt-4">
                            <div class="card-header">
                                <h5><i class="fas fa-bolt"></i> Quick Actions</h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-3 mb-2">
                                        <a href="${pageContext.request.contextPath}/certificate/view/${certificate.certificateId}" 
                                           class="btn btn-primary w-100">
                                            <i class="fas fa-eye"></i> View Certificate
                                        </a>
                                    </div>
                                    <div class="col-md-3 mb-2">
                                        <a href="${pageContext.request.contextPath}/pdf/download/${certificate.certificateId}" 
                                           class="btn btn-danger w-100">
                                            <i class="fas fa-file-pdf"></i> Download PDF
                                        </a>
                                    </div>
                                    <div class="col-md-3 mb-2">
                                        <a href="${pageContext.request.contextPath}/verify?id=${certificate.certificateId}" 
                                           class="btn btn-success w-100">
                                            <i class="fas fa-check-circle"></i> Verify
                                        </a>
                                    </div>
                                    <div class="col-md-3 mb-2">
                                        <button class="btn btn-info w-100" onclick="copyVerificationUrl()">
                                            <i class="fas fa-copy"></i> Copy URL
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Status Management -->
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-header">
                                <h5><i class="fas fa-toggle-on"></i> Status Management</h5>
                            </div>
                            <div class="card-body">
                                <form action="${pageContext.request.contextPath}/admin/update-status/${certificate.certificateId}" method="post">
                                    <div class="mb-3">
                                        <label for="status" class="form-label">Certificate Status</label>
                                        <select class="form-select" id="status" name="status" required>
                                            <option value="ACTIVE" ${certificate.status == 'ACTIVE' ? 'selected' : ''}>
                                                Active
                                            </option>
                                            <option value="REVOKED" ${certificate.status == 'REVOKED' ? 'selected' : ''}>
                                                Revoked
                                            </option>
                                            <option value="SUSPENDED" ${certificate.status == 'SUSPENDED' ? 'selected' : ''}>
                                                Suspended
                                            </option>
                                        </select>
                                    </div>
                                    
                                    <div class="d-grid">
                                        <button type="submit" class="btn btn-warning">
                                            <i class="fas fa-save"></i> Update Status
                                        </button>
                                    </div>
                                </form>

                                <hr>

                                <div class="text-center">
                                    <h6>Status Meanings:</h6>
                                    <div class="small text-muted">
                                        <p><span class="badge bg-success">ACTIVE</span> - Certificate is valid and verifiable</p>
                                        <p><span class="badge bg-danger">REVOKED</span> - Certificate has been permanently revoked</p>
                                        <p><span class="badge bg-warning">SUSPENDED</span> - Certificate is temporarily suspended</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- QR Code -->
                        <c:if test="${not empty certificate.qrCode}">
                            <div class="card mt-4">
                                <div class="card-header">
                                    <h5><i class="fas fa-qrcode"></i> QR Code</h5>
                                </div>
                                <div class="card-body text-center">
                                    <img src="data:image/png;base64,${certificate.qrCode}" 
                                         alt="QR Code for verification" 
                                         class="img-fluid" style="max-width: 200px;">
                                    <p class="small mt-2 text-muted">Scan to verify certificate</p>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>

                <!-- Verification URL -->
                <div class="row mt-4">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h5><i class="fas fa-link"></i> Verification Information</h5>
                            </div>
                            <div class="card-body">
                                <div class="mb-3">
                                    <label class="form-label">Verification URL:</label>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="verificationUrl" readonly
                                               value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/verify?id=${certificate.certificateId}">
                                        <button class="btn btn-outline-secondary" onclick="copyVerificationUrl()">
                                            <i class="fas fa-copy"></i> Copy
                                        </button>
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <label class="form-label">API Verification URL:</label>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="apiUrl" readonly
                                               value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/verify?id=${certificate.certificateId}&format=json">
                                        <button class="btn btn-outline-secondary" onclick="copyApiUrl()">
                                            <i class="fas fa-copy"></i> Copy
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function copyVerificationUrl() {
            const urlField = document.getElementById('verificationUrl');
            urlField.select();
            urlField.setSelectionRange(0, 99999);
            navigator.clipboard.writeText(urlField.value);
            
            // Show feedback
            showCopyFeedback('Verification URL copied to clipboard!');
        }
        
        function copyApiUrl() {
            const urlField = document.getElementById('apiUrl');
            urlField.select();
            urlField.setSelectionRange(0, 99999);
            navigator.clipboard.writeText(urlField.value);
            
            // Show feedback
            showCopyFeedback('API URL copied to clipboard!');
        }
        
        function showCopyFeedback(message) {
            // Create temporary alert
            const alert = document.createElement('div');
            alert.className = 'alert alert-success alert-dismissible fade show position-fixed';
            alert.style.top = '20px';
            alert.style.right = '20px';
            alert.style.zIndex = '9999';
            alert.innerHTML = `
                <i class="fas fa-check"></i> ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            `;
            
            document.body.appendChild(alert);
            
            // Auto remove after 3 seconds
            setTimeout(() => {
                if (alert.parentNode) {
                    alert.parentNode.removeChild(alert);
                }
            }, 3000);
        }
    </script>
</body>
</html>