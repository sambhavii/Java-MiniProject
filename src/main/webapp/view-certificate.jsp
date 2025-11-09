<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Certificate - ${certificate.certificateId}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .certificate-container {
            border: 3px solid #007bff;
            border-radius: 15px;
            padding: 40px;
            margin: 20px 0;
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            position: relative;
        }
        .certificate-title {
            font-size: 2.5rem;
            font-weight: bold;
            color: #007bff;
            text-transform: uppercase;
            letter-spacing: 2px;
        }
        .student-name {
            font-size: 2rem;
            font-weight: bold;
            color: #333;
            border-bottom: 2px solid #007bff;
            display: inline-block;
            padding-bottom: 5px;
        }
        .course-name {
            font-size: 1.5rem;
            font-weight: bold;
            color: #6c757d;
        }
        .qr-code {
            position: absolute;
            bottom: 20px;
            right: 20px;
        }
        .certificate-seal {
            position: absolute;
            top: 20px;
            left: 20px;
            width: 80px;
            height: 80px;
            border: 3px solid #007bff;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            background: white;
        }
        @media print {
            .no-print { display: none !important; }
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark no-print">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="fas fa-certificate"></i> Certificate Generator
            </a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="${pageContext.request.contextPath}/">Home</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/certificate/">Create New</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/certificate/list">View All</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <!-- Action Buttons -->
        <div class="row no-print mb-3">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center">
                    <h2><i class="fas fa-certificate"></i> Certificate Details</h2>
                    <div>
                        <a href="${pageContext.request.contextPath}/pdf/download/${certificate.certificateId}" 
                           class="btn btn-danger me-2">
                            <i class="fas fa-file-pdf"></i> Download PDF
                        </a>
                        <button onclick="window.print()" class="btn btn-secondary me-2">
                            <i class="fas fa-print"></i> Print
                        </button>
                        <a href="${pageContext.request.contextPath}/verify?id=${certificate.certificateId}" 
                           class="btn btn-success">
                            <i class="fas fa-check-circle"></i> Verify
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Certificate Display -->
        <div class="row">
            <div class="col-12">
                <div class="certificate-container text-center">
                    <!-- Certificate Seal -->
                    <div class="certificate-seal">
                        <i class="fas fa-award fa-2x text-primary"></i>
                    </div>

                    <!-- Certificate Content -->
                    <div class="certificate-title mb-4">
                        <c:choose>
                            <c:when test="${certificate.templateType == 'COURSE_COMPLETION'}">
                                Certificate of Completion
                            </c:when>
                            <c:when test="${certificate.templateType == 'PARTICIPATION'}">
                                Certificate of Participation
                            </c:when>
                            <c:when test="${certificate.templateType == 'EXCELLENCE'}">
                                Certificate of Excellence
                            </c:when>
                            <c:otherwise>
                                Certificate
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="mb-4">
                        <h4 class="text-primary">${certificate.institutionName}</h4>
                    </div>

                    <div class="mb-4">
                        <p class="lead">This is to certify that</p>
                        <div class="student-name mb-3">${certificate.studentName}</div>
                        
                        <c:choose>
                            <c:when test="${certificate.templateType == 'COURSE_COMPLETION'}">
                                <p class="lead">has successfully completed the course</p>
                            </c:when>
                            <c:when test="${certificate.templateType == 'PARTICIPATION'}">
                                <p class="lead">has actively participated in</p>
                            </c:when>
                            <c:when test="${certificate.templateType == 'EXCELLENCE'}">
                                <p class="lead">has demonstrated excellence in</p>
                            </c:when>
                            <c:otherwise>
                                <p class="lead">has completed</p>
                            </c:otherwise>
                        </c:choose>
                        
                        <div class="course-name mb-3">${certificate.course}</div>
                        
                        <c:if test="${not empty certificate.grade}">
                            <p class="lead">Grade: <strong>${certificate.grade}</strong></p>
                        </c:if>
                    </div>

                    <div class="row mt-5">
                        <div class="col-md-6">
                            <p><strong>Date of Issue:</strong> ${certificate.issueDate}</p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>Certificate ID:</strong> ${certificate.certificateId}</p>
                        </div>
                    </div>

                    <div class="row mt-3">
                        <div class="col-md-6">
                            <p><strong>Status:</strong> 
                                <span class="badge ${certificate.status == 'ACTIVE' ? 'bg-success' : 'bg-warning'}">
                                    ${certificate.status}
                                </span>
                            </p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>Digital Signature:</strong> ${certificate.digitalSignature}</p>
                        </div>
                    </div>

                    <!-- QR Code -->
                    <c:if test="${not empty certificate.qrCode}">
                        <div class="qr-code">
                            <img src="data:image/png;base64,${certificate.qrCode}" 
                                 alt="QR Code for verification" 
                                 style="width: 100px; height: 100px;">
                            <p class="small mt-1">Scan to verify</p>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Certificate Information -->
        <div class="row no-print mt-4">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        <h5><i class="fas fa-info-circle"></i> Certificate Information</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <p><strong>Certificate ID:</strong> ${certificate.certificateId}</p>
                                <p><strong>Student Name:</strong> ${certificate.studentName}</p>
                                <p><strong>Course:</strong> ${certificate.course}</p>
                            </div>
                            <div class="col-md-6">
                                <p><strong>Grade:</strong> ${certificate.grade}</p>
                                <p><strong>Template:</strong> ${certificate.templateType}</p>
                                <p><strong>Institution:</strong> ${certificate.institutionName}</p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12">
                                <p><strong>Verification URL:</strong> 
                                    <a href="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/verify?id=${certificate.certificateId}" 
                                       target="_blank">
                                        ${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/verify?id=${certificate.certificateId}
                                    </a>
                                </p>
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