<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Certificate List - Certificate Generator</title>
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
                <a class="nav-link" href="${pageContext.request.contextPath}/verify">Verify</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2><i class="fas fa-list"></i> All Certificates</h2>
            <a href="${pageContext.request.contextPath}/certificate/" class="btn btn-primary">
                <i class="fas fa-plus"></i> Create New Certificate
            </a>
        </div>

        <c:choose>
            <c:when test="${not empty certificates}">
                <div class="row">
                    <c:forEach var="cert" items="${certificates}">
                        <div class="col-md-6 col-lg-4 mb-4">
                            <div class="card h-100">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    <small class="text-muted">${cert.certificateId}</small>
                                    <span class="badge ${cert.status == 'ACTIVE' ? 'bg-success' : 'bg-warning'}">
                                        ${cert.status}
                                    </span>
                                </div>
                                <div class="card-body">
                                    <h5 class="card-title">${cert.studentName}</h5>
                                    <p class="card-text">
                                        <strong>Course:</strong> ${cert.course}<br>
                                        <c:if test="${not empty cert.grade}">
                                            <strong>Grade:</strong> ${cert.grade}<br>
                                        </c:if>
                                        <strong>Institution:</strong> ${cert.institutionName}<br>
                                        <strong>Template:</strong> ${cert.templateType}<br>
                                        <small class="text-muted">Issued: ${cert.issueDate}</small>
                                    </p>
                                </div>
                                <div class="card-footer">
                                    <div class="btn-group w-100" role="group">
                                        <a href="${pageContext.request.contextPath}/certificate/view/${cert.certificateId}" 
                                           class="btn btn-outline-primary btn-sm">
                                            <i class="fas fa-eye"></i> View
                                        </a>
                                        <a href="${pageContext.request.contextPath}/pdf/download/${cert.certificateId}" 
                                           class="btn btn-outline-danger btn-sm">
                                            <i class="fas fa-file-pdf"></i> PDF
                                        </a>
                                        <a href="${pageContext.request.contextPath}/verify?id=${cert.certificateId}" 
                                           class="btn btn-outline-success btn-sm">
                                            <i class="fas fa-check"></i> Verify
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="text-center py-5">
                    <i class="fas fa-certificate fa-4x text-muted mb-3"></i>
                    <h4 class="text-muted">No certificates found</h4>
                    <p class="text-muted">Create your first certificate to get started.</p>
                    <a href="${pageContext.request.contextPath}/certificate/" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Create Certificate
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>