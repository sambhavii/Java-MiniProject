package com.certificate.servlet;

import com.certificate.model.Certificate;
import com.certificate.util.XMLManager;
import com.certificate.util.PDFGenerator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;

public class PDFServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo != null && pathInfo.startsWith("/download/")) {
            String certificateId = pathInfo.substring(10);
            downloadCertificatePDF(request, response, certificateId);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid request");
        }
    }
    
    private void downloadCertificatePDF(HttpServletRequest request, HttpServletResponse response, String certificateId) 
            throws ServletException, IOException {
        
        try {
            Certificate certificate = XMLManager.getCertificate(certificateId);
            
            if (certificate == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Certificate not found");
                return;
            }
            
            if (!"ACTIVE".equals(certificate.getStatus())) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Certificate is not active");
                return;
            }
            
            String baseUrl = getBaseUrl(request);
            byte[] pdfBytes = PDFGenerator.generateCertificatePDF(certificate, baseUrl);
            
            // Set response headers for PDF download
            response.setContentType("application/pdf");
            response.setContentLength(pdfBytes.length);
            
            String filename = "Certificate_" + certificate.getCertificateId() + ".pdf";
            response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
            
            // Write PDF to response
            OutputStream out = response.getOutputStream();
            out.write(pdfBytes);
            out.flush();
            out.close();
            
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                             "Error generating PDF: " + e.getMessage());
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
}