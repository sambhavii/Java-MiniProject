<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Certificate Generator</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .stat-card {
            transition: transform 0.2s;
        }
        .stat-card:hover {
            transform: translateY(-2px);
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
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="${pageContext.request.contextPath}/">Home</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/certificate/">Create Certificate</a>
                <a class="nav-link active" href="${pageContext.request.contextPath}/admin/dashboard">Admin</a>
            </div>
        </div>
    </nav>

    <div class="container-fluid mt-4">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 col-lg-2">
                <div class="card">
                    <div class="card-header">
                        <h5><i class="fas fa-tachometer-alt"></i> Admin Panel</h5>
                    </div>
                    <div class="list-group list-group-flush">
                        <a href="${pageContext.request.contextPath}/admin/dashboard" 
                           class="list-group-item list-group-item-action active">
                            <i class="fas fa-chart-bar"></i> Dashboard
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/certificates" 
                           class="list-group-item list-group-item-action">
                            <i class="fas fa-certificate"></i> All Certificates
                        </a>
                        <a href="${pageContext.request.contextPath}/certificate/" 
                           class="list-group-item list-group-item-action">
                            <i class="fas fa-plus"></i> Create Certificate
                        </a>
                        <a href="${pageContext.request.contextPath}/bulk-create.jsp" 
                           class="list-group-item list-group-item-action">
                            <i class="fas fa-users"></i> Bulk Create
                        </a>
                    </div>
                </div>
            </div>

            <!-- Main Content -->
            <div class="col-md-9 col-lg-10">
                <h2><i class="fas fa-tachometer-alt"></i> Admin Dashboard</h2>
                
                <!-- Statistics Cards -->
                <div class="row mb-4">
                    <div class="col-md-4 mb-3">
                        <div class="card stat-card bg-primary text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h4>${totalCertificates}</h4>
                                        <p class="mb-0">Total Certificates</p>
                                    </div>
                                    <div class="align-self-center">
                                        <i class="fas fa-certificate fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <div class="card stat-card bg-success text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h4>${activeCertificates}</h4>
                                        <p class="mb-0">Active Certificates</p>
                                    </div>
                                    <div class="align-self-center">
                                        <i class="fas fa-check-circle fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <div class="card stat-card bg-warning text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h4>${revokedCertificates}</h4>
                                        <p class="mb-0">Revoked Certificates</p>
                                    </div>
                                    <div class="align-self-center">
                                        <i class="fas fa-times-circle fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="row mb-4">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h5><i class="fas fa-bolt"></i> Quick Actions</h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-3 mb-2">
                                        <a href="${pageContext.request.contextPath}/certificate/" 
                                           class="btn btn-primary w-100">
                                            <i class="fas fa-plus"></i> Create Certificate
                                        </a>
                                    </div>
                                    <div class="col-md-3 mb-2">
                                        <a href="${pageContext.request.contextPath}/bulk-create.jsp" 
                                           class="btn btn-info w-100">
                                            <i class="fas fa-users"></i> Bulk Create
                                        </a>
                                    </div>
                                    <div class="col-md-3 mb-2">
                                        <a href="${pageContext.request.contextPath}/admin/certificates" 
                                           class="btn btn-secondary w-100">
                                            <i class="fas fa-list"></i> View All
                                        </a>
                                    </div>
                                    <div class="col-md-3 mb-2">
                                        <a href="${pageContext.request.contextPath}/verify" 
                                           class="btn btn-success w-100">
                                            <i class="fas fa-search"></i> Verify Certificate
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Recent Certificates -->
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h5><i class="fas fa-clock"></i> Recent Certificates</h5>
                                <a href="${pageContext.request.contextPath}/admin/certificates" 
                                   class="btn btn-sm btn-outline-primary">View All</a>
                            </div>
                            <div class="card-body">
                                <c:choose>
                                    <c:when test="${not empty recentCertificates}">
                                        <div class="table-responsive">
                                            <table class="table table-hover">
                                                <thead>
                                                    <tr>
                                                        <th>Certificate ID</th>
                                                        <th>Student Name</th>
                                                        <th>Course</th>
                                                        <th>Issue Date</th>
                                                        <th>Status</th>
                                                        <th>Actions</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="cert" items="${recentCertificates}">
                                                        <tr>
                                                            <td>
                                                                <code>${cert.certificateId}</code>
                                                            </td>
                                                            <td>${cert.studentName}</td>
                                                            <td>${cert.course}</td>
                                                            <td>${cert.issueDate}</td>
                                                            <td>
                                                                <span class="badge ${cert.status == 'ACTIVE' ? 'bg-success' : 'bg-warning'}">
                                                                    ${cert.status}
                                                                </span>
                                                            </td>
                                                            <td>
                                                                <a href="${pageContext.request.contextPath}/certificate/view/${cert.certificateId}" 
                                                                   class="btn btn-sm btn-outline-primary" title="View">
                                                                    <i class="fas fa-eye"></i>
                                                                </a>
                                                                <a href="${pageContext.request.contextPath}/admin/certificate/${cert.certificateId}" 
                                                                   class="btn btn-sm btn-outline-secondary" title="Manage">
                                                                    <i class="fas fa-cog"></i>
                                                                </a>
                                                                <a href="${pageContext.request.contextPath}/pdf/download/${cert.certificateId}" 
                                                                   class="btn btn-sm btn-outline-danger" title="Download PDF">
                                                                    <i class="fas fa-file-pdf"></i>
                                                                </a>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="text-center py-4">
                                            <i class="fas fa-certificate fa-3x text-muted mb-3"></i>
                                            <p class="text-muted">No certificates found. Create your first certificate!</p>
                                            <a href="${pageContext.request.contextPath}/certificate/" 
                                               class="btn btn-primary">
                                                <i class="fas fa-plus"></i> Create Certificate
                                            </a>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>