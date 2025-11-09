<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Certificate - Certificate Generator</title>
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
                <a class="nav-link" href="${pageContext.request.contextPath}/certificate/list">View Certificates</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/verify">Verify</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">
                        <h3><i class="fas fa-plus-circle"></i> Create New Certificate</h3>
                    </div>
                    <div class="card-body">
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger" role="alert">
                                <i class="fas fa-exclamation-triangle"></i> ${error}
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/certificate/create" method="post">
                            <div class="mb-3">
                                <label for="studentName" class="form-label">Student Name *</label>
                                <input type="text" class="form-control" id="studentName" name="studentName" 
                                       value="${param.studentName}" required>
                            </div>

                            <div class="mb-3">
                                <label for="course" class="form-label">Course/Event Name *</label>
                                <input type="text" class="form-control" id="course" name="course" 
                                       value="${param.course}" required>
                            </div>

                            <div class="mb-3">
                                <label for="grade" class="form-label">Grade/Score (Optional)</label>
                                <input type="text" class="form-control" id="grade" name="grade" 
                                       value="${param.grade}" placeholder="e.g., A+, 95%, Excellent">
                            </div>

                            <div class="mb-3">
                                <label for="templateType" class="form-label">Certificate Template *</label>
                                <select class="form-select" id="templateType" name="templateType" required>
                                    <option value="">Select Template</option>
                                    <option value="COURSE_COMPLETION" ${param.templateType == 'COURSE_COMPLETION' ? 'selected' : ''}>
                                        Course Completion
                                    </option>
                                    <option value="PARTICIPATION" ${param.templateType == 'PARTICIPATION' ? 'selected' : ''}>
                                        Participation
                                    </option>
                                    <option value="EXCELLENCE" ${param.templateType == 'EXCELLENCE' ? 'selected' : ''}>
                                        Excellence Award
                                    </option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label for="institutionName" class="form-label">Institution Name *</label>
                                <input type="text" class="form-control" id="institutionName" name="institutionName" 
                                       value="${param.institutionName}" required>
                            </div>

                            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                <a href="${pageContext.request.contextPath}/" class="btn btn-secondary me-md-2">
                                    <i class="fas fa-arrow-left"></i> Back
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-certificate"></i> Create Certificate
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Bulk Creation Option -->
                <div class="card mt-4">
                    <div class="card-header">
                        <h5><i class="fas fa-users"></i> Bulk Certificate Creation</h5>
                    </div>
                    <div class="card-body">
                        <p class="text-muted">Need to create multiple certificates? Use our bulk creation feature.</p>
                        <a href="${pageContext.request.contextPath}/bulk-create.jsp" class="btn btn-outline-primary">
                            <i class="fas fa-upload"></i> Bulk Create Certificates
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>