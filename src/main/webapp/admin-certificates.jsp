<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Certificates - Certificate Generator</title>
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
                           class="list-group-item list-group-item-action">
                            <i class="fas fa-chart-bar"></i> Dashboard
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/certificates" 
                           class="list-group-item list-group-item-action active">
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
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2><i class="fas fa-certificate"></i> Manage Certificates</h2>
                    <a href="${pageContext.request.contextPath}/certificate/" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Create New Certificate
                    </a>
                </div>

                <!-- Search and Filter -->
                <div class="card mb-4">
                    <div class="card-body">
                        <form method="get" action="${pageContext.request.contextPath}/admin/certificates">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="input-group">
                                        <input type="text" class="form-control" name="search" 
                                               value="${searchQuery}" placeholder="Search by name, course, or certificate ID">
                                        <button class="btn btn-outline-secondary" type="submit">
                                            <i class="fas fa-search"></i> Search
                                        </button>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <select class="form-select" name="status" onchange="this.form.submit()">
                                        <option value="">All Status</option>
                                        <option value="ACTIVE" ${statusFilter == 'ACTIVE' ? 'selected' : ''}>Active</option>
                                        <option value="REVOKED" ${statusFilter == 'REVOKED' ? 'selected' : ''}>Revoked</option>
                                        <option value="SUSPENDED" ${statusFilter == 'SUSPENDED' ? 'selected' : ''}>Suspended</option>
                                    </select>
                                </div>
                                <div class="col-md-2">
                                    <a href="${pageContext.request.contextPath}/admin/certificates" class="btn btn-outline-secondary w-100">
                                        <i class="fas fa-times"></i> Clear
                                    </a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Certificates Table -->
                <div class="card">
                    <div class="card-header">
                        <h5><i class="fas fa-list"></i> Certificates List</h5>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty certificates}">
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th>Certificate ID</th>
                                                <th>Student Name</th>
                                                <th>Course</th>
                                                <th>Grade</th>
                                                <th>Issue Date</th>
                                                <th>Status</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="cert" items="${certificates}">
                                                <tr>
                                                    <td>
                                                        <code class="small">${cert.certificateId}</code>
                                                    </td>
                                                    <td>${cert.studentName}</td>
                                                    <td>${cert.course}</td>
                                                    <td>${cert.grade}</td>
                                                    <td class="small">${cert.issueDate}</td>
                                                    <td>
                                                        <span class="badge ${cert.status == 'ACTIVE' ? 'bg-success' : cert.status == 'REVOKED' ? 'bg-danger' : 'bg-warning'}">
                                                            ${cert.status}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <div class="btn-group" role="group">
                                                            <a href="${pageContext.request.contextPath}/certificate/view/${cert.certificateId}" 
                                                               class="btn btn-sm btn-outline-primary" title="View Certificate">
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
                                                            <a href="${pageContext.request.contextPath}/verify?id=${cert.certificateId}" 
                                                               class="btn btn-sm btn-outline-success" title="Verify">
                                                                <i class="fas fa-check-circle"></i>
                                                            </a>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-5">
                                    <i class="fas fa-certificate fa-4x text-muted mb-3"></i>
                                    <h5 class="text-muted">No certificates found</h5>
                                    <c:choose>
                                        <c:when test="${not empty searchQuery or not empty statusFilter}">
                                            <p class="text-muted">Try adjusting your search criteria or filters.</p>
                                            <a href="${pageContext.request.contextPath}/admin/certificates" class="btn btn-outline-primary">
                                                <i class="fas fa-times"></i> Clear Filters
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <p class="text-muted">Create your first certificate to get started.</p>
                                            <a href="${pageContext.request.contextPath}/certificate/" class="btn btn-primary">
                                                <i class="fas fa-plus"></i> Create Certificate
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>