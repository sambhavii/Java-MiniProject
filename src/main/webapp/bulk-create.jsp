<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bulk Create Certificates - Certificate Generator</title>
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
                <a class="nav-link" href="${pageContext.request.contextPath}/certificate/">Create Single</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">Admin</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-10">
                <div class="card">
                    <div class="card-header">
                        <h3><i class="fas fa-users"></i> Bulk Certificate Creation</h3>
                    </div>
                    <div class="card-body">
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

                        <!-- Instructions -->
                        <div class="alert alert-info" role="alert">
                            <h5><i class="fas fa-info-circle"></i> Instructions</h5>
                            <ul class="mb-0">
                                <li>Enter student data in the format: <code>Student Name, Grade (optional)</code></li>
                                <li>Put each student on a new line</li>
                                <li>Grade is optional - if not provided, leave it blank after the comma or omit the comma</li>
                                <li>Example: <code>John Doe, A+</code> or <code>Jane Smith</code></li>
                            </ul>
                        </div>

                        <form action="${pageContext.request.contextPath}/certificate/bulk-create" method="post">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="course" class="form-label">Course/Event Name *</label>
                                        <input type="text" class="form-control" id="course" name="course" 
                                               value="${param.course}" required>
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
                                </div>

                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="studentsData" class="form-label">Students Data *</label>
                                        <textarea class="form-control" id="studentsData" name="studentsData" 
                                                  rows="12" required placeholder="John Doe, A+
Jane Smith, B
Bob Johnson
Alice Brown, Excellent
Mike Wilson, 95%">${param.studentsData}</textarea>
                                        <div class="form-text">
                                            Enter one student per line. Format: Name, Grade (optional)
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                <a href="${pageContext.request.contextPath}/certificate/" class="btn btn-secondary me-md-2">
                                    <i class="fas fa-arrow-left"></i> Back to Single Create
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-users"></i> Create Bulk Certificates
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Sample Data -->
                <div class="card mt-4">
                    <div class="card-header">
                        <h5><i class="fas fa-clipboard-list"></i> Sample Data</h5>
                    </div>
                    <div class="card-body">
                        <p class="text-muted">You can copy and paste this sample data to test bulk creation:</p>
                        <div class="bg-light p-3 rounded">
                            <code>
                                John Doe, A+<br>
                                Jane Smith, B<br>
                                Bob Johnson<br>
                                Alice Brown, Excellent<br>
                                Mike Wilson, 95%<br>
                                Sarah Davis, A<br>
                                Tom Anderson, B+<br>
                                Lisa Garcia<br>
                                David Martinez, Outstanding<br>
                                Emma Thompson, A-
                            </code>
                        </div>
                        <button class="btn btn-sm btn-outline-primary mt-2" onclick="copySampleData()">
                            <i class="fas fa-copy"></i> Copy Sample Data
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function copySampleData() {
            const sampleData = `John Doe, A+
Jane Smith, B
Bob Johnson
Alice Brown, Excellent
Mike Wilson, 95%
Sarah Davis, A
Tom Anderson, B+
Lisa Garcia
David Martinez, Outstanding
Emma Thompson, A-`;
            
            document.getElementById('studentsData').value = sampleData;
            
            // Show feedback
            const button = event.target;
            const originalText = button.innerHTML;
            button.innerHTML = '<i class="fas fa-check"></i> Copied!';
            button.classList.remove('btn-outline-primary');
            button.classList.add('btn-success');
            
            setTimeout(() => {
                button.innerHTML = originalText;
                button.classList.remove('btn-success');
                button.classList.add('btn-outline-primary');
            }, 2000);
        }
    </script>
</body>
</html>