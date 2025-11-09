package com.certificate.servlet;

import com.certificate.model.Certificate;
import com.certificate.util.XMLManager;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class VerificationServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String certificateId = request.getParameter("id");
        String format = request.getParameter("format");
        
        if (certificateId == null || certificateId.trim().isEmpty()) {
            // Show verification form
            request.getRequestDispatcher("/verify-certificate.jsp").forward(request, response);
            return;
        }
        
        try {
            Certificate certificate = XMLManager.getCertificate(certificateId.trim());
            
            if ("json".equals(format)) {
                // Return JSON response for API calls
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                
                PrintWriter out = response.getWriter();
                ObjectMapper mapper = new ObjectMapper();
                
                if (certificate != null && "ACTIVE".equals(certificate.getStatus())) {
                    VerificationResponse verificationResponse = new VerificationResponse(
                        true, "Certificate is valid", certificate);
                    out.print(mapper.writeValueAsString(verificationResponse));
                } else if (certificate != null && !"ACTIVE".equals(certificate.getStatus())) {
                    VerificationResponse verificationResponse = new VerificationResponse(
                        false, "Certificate status: " + certificate.getStatus(), certificate);
                    out.print(mapper.writeValueAsString(verificationResponse));
                } else {
                    VerificationResponse verificationResponse = new VerificationResponse(
                        false, "Certificate not found", null);
                    out.print(mapper.writeValueAsString(verificationResponse));
                }
                out.flush();
            } else {
                // Show verification result page
                if (certificate != null) {
                    request.setAttribute("certificate", certificate);
                    request.setAttribute("isValid", "ACTIVE".equals(certificate.getStatus()));
                    
                    if (!"ACTIVE".equals(certificate.getStatus())) {
                        request.setAttribute("statusMessage", "Certificate status: " + certificate.getStatus());
                    }
                } else {
                    request.setAttribute("isValid", false);
                    request.setAttribute("errorMessage", "Certificate not found");
                }
                
                request.getRequestDispatcher("/verification-result.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            if ("json".equals(format)) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();
                ObjectMapper mapper = new ObjectMapper();
                VerificationResponse verificationResponse = new VerificationResponse(
                    false, "Error verifying certificate: " + e.getMessage(), null);
                out.print(mapper.writeValueAsString(verificationResponse));
                out.flush();
            } else {
                request.setAttribute("error", "Error verifying certificate: " + e.getMessage());
                request.getRequestDispatcher("/error.jsp").forward(request, response);
            }
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Handle form submission for verification
        String certificateId = request.getParameter("certificateId");
        
        if (certificateId != null && !certificateId.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/verify?id=" + certificateId.trim());
        } else {
            request.setAttribute("error", "Certificate ID is required");
            request.getRequestDispatcher("/verify-certificate.jsp").forward(request, response);
        }
    }
    
    // Inner class for JSON response
    public static class VerificationResponse {
        private boolean valid;
        private String message;
        private Certificate certificate;
        
        public VerificationResponse(boolean valid, String message, Certificate certificate) {
            this.valid = valid;
            this.message = message;
            this.certificate = certificate;
        }
        
        // Getters
        public boolean isValid() { return valid; }
        public String getMessage() { return message; }
        public Certificate getCertificate() { return certificate; }
        
        // Setters
        public void setValid(boolean valid) { this.valid = valid; }
        public void setMessage(String message) { this.message = message; }
        public void setCertificate(Certificate certificate) { this.certificate = certificate; }
    }
}