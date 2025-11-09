package com.certificate.servlet;

import com.certificate.model.Certificate;
import com.certificate.util.XMLManager;
import com.certificate.util.QRCodeGenerator;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class CertificateServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // Show certificate creation form
            request.getRequestDispatcher("/create-certificate.jsp").forward(request, response);
        } else if (pathInfo.equals("/list")) {
            // List all certificates
            try {
                List<Certificate> certificates = XMLManager.getAllCertificates();
                request.setAttribute("certificates", certificates);
                request.getRequestDispatcher("/certificate-list.jsp").forward(request, response);
            } catch (Exception e) {
                request.setAttribute("error", "Error loading certificates: " + e.getMessage());
                request.getRequestDispatcher("/error.jsp").forward(request, response);
            }
        } else if (pathInfo.startsWith("/view/")) {
            // View specific certificate
            String certificateId = pathInfo.substring(6);
            try {
                Certificate certificate = XMLManager.getCertificate(certificateId);
                if (certificate != null) {
                    request.setAttribute("certificate", certificate);
                    request.getRequestDispatcher("/view-certificate.jsp").forward(request, response);
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Certificate not found");
                }
            } catch (Exception e) {
                request.setAttribute("error", "Error loading certificate: " + e.getMessage());
                request.getRequestDispatcher("/error.jsp").forward(request, response);
            }
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/create")) {
            // Create new certificate
            createCertificate(request, response);
        } else if (pathInfo.equals("/bulk-create")) {
            // Bulk certificate creation
            bulkCreateCertificates(request, response);
        }
    }
    
    private void createCertificate(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String studentName = request.getParameter("studentName");
            String course = request.getParameter("course");
            String grade = request.getParameter("grade");
            String templateType = request.getParameter("templateType");
            String institutionName = request.getParameter("institutionName");
            
            // Validate required fields
            if (studentName == null || studentName.trim().isEmpty() ||
                course == null || course.trim().isEmpty() ||
                templateType == null || templateType.trim().isEmpty() ||
                institutionName == null || institutionName.trim().isEmpty()) {
                
                request.setAttribute("error", "All required fields must be filled");
                request.getRequestDispatcher("/create-certificate.jsp").forward(request, response);
                return;
            }
            
            // Create certificate
            Certificate certificate = new Certificate(studentName.trim(), course.trim(), 
                                                    grade != null ? grade.trim() : "", 
                                                    templateType, institutionName.trim());
            
            // Generate QR code
            String baseUrl = getBaseUrl(request);
            String qrCode = QRCodeGenerator.generateQRCode(certificate.getCertificateId(), baseUrl);
            certificate.setQrCode(qrCode);
            
            // Generate digital signature (simplified)
            certificate.setDigitalSignature(generateDigitalSignature(certificate));
            
            // Save to XML
            XMLManager.saveCertificate(certificate);
            
            // Redirect to view certificate
            response.sendRedirect(request.getContextPath() + "/certificate/view/" + certificate.getCertificateId());
            
        } catch (Exception e) {
            request.setAttribute("error", "Error creating certificate: " + e.getMessage());
            request.getRequestDispatcher("/create-certificate.jsp").forward(request, response);
        }
    }
    
    private void bulkCreateCertificates(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String studentsData = request.getParameter("studentsData");
            String course = request.getParameter("course");
            String templateType = request.getParameter("templateType");
            String institutionName = request.getParameter("institutionName");
            
            if (studentsData == null || studentsData.trim().isEmpty()) {
                request.setAttribute("error", "Students data is required");
                request.getRequestDispatcher("/bulk-create.jsp").forward(request, response);
                return;
            }
            
            String[] lines = studentsData.split("\n");
            int createdCount = 0;
            
            for (String line : lines) {
                line = line.trim();
                if (!line.isEmpty()) {
                    String[] parts = line.split(",");
                    if (parts.length >= 1) {
                        String studentName = parts[0].trim();
                        String grade = parts.length > 1 ? parts[1].trim() : "";
                        
                        Certificate certificate = new Certificate(studentName, course, grade, templateType, institutionName);
                        
                        String baseUrl = getBaseUrl(request);
                        String qrCode = QRCodeGenerator.generateQRCode(certificate.getCertificateId(), baseUrl);
                        certificate.setQrCode(qrCode);
                        certificate.setDigitalSignature(generateDigitalSignature(certificate));
                        
                        XMLManager.saveCertificate(certificate);
                        createdCount++;
                    }
                }
            }
            
            request.setAttribute("message", "Successfully created " + createdCount + " certificates");
            request.getRequestDispatcher("/certificate/list").forward(request, response);
            
        } catch (Exception e) {
            request.setAttribute("error", "Error creating bulk certificates: " + e.getMessage());
            request.getRequestDispatcher("/bulk-create.jsp").forward(request, response);
        }
    }
    
    private String getBaseUrl(HttpServletRequest request) {
        String scheme = request.getScheme();
        String serverName = request.getServerName();
        int serverPort = request.getServerPort();
        String contextPath = request.getContextPath();
        
        StringBuilder url = new StringBuilder();
        url.append(scheme).append("://").append(serverName);
        
        if ((scheme.equals("http") && serverPort != 80) || 
            (scheme.equals("https") && serverPort != 443)) {
            url.append(":").append(serverPort);
        }
        
        url.append(contextPath);
        return url.toString();
    }
    
    private String generateDigitalSignature(Certificate certificate) {
        // Simplified digital signature - in production, use proper cryptographic signing
        String data = certificate.getCertificateId() + certificate.getStudentName() + 
                     certificate.getCourse() + certificate.getIssueDate();
        return "SIG-" + Math.abs(data.hashCode());
    }
}