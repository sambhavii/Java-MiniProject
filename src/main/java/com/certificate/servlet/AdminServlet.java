package com.certificate.servlet;

import com.certificate.model.Certificate;
import com.certificate.util.XMLManager;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class AdminServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/") || pathInfo.equals("/dashboard")) {
            // Show admin dashboard
            showDashboard(request, response);
        } else if (pathInfo.equals("/certificates")) {
            // Show all certificates for admin
            showAllCertificates(request, response);
        } else if (pathInfo.startsWith("/certificate/")) {
            // Show specific certificate details for admin
            String certificateId = pathInfo.substring(13);
            showCertificateDetails(request, response, certificateId);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo != null && pathInfo.startsWith("/update-status/")) {
            // Update certificate status
            String certificateId = pathInfo.substring(15);
            updateCertificateStatus(request, response, certificateId);
        }
    }
    
    private void showDashboard(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            List<Certificate> allCertificates = XMLManager.getAllCertificates();
            
            // Calculate statistics
            int totalCertificates = allCertificates.size();
            int activeCertificates = 0;
            int revokedCertificates = 0;
            
            for (Certificate cert : allCertificates) {
                if ("ACTIVE".equals(cert.getStatus())) {
                    activeCertificates++;
                } else if ("REVOKED".equals(cert.getStatus())) {
                    revokedCertificates++;
                }
            }
            
            // Get recent certificates (last 10)
            List<Certificate> recentCertificates = allCertificates.size() > 10 ? 
                allCertificates.subList(Math.max(0, allCertificates.size() - 10), allCertificates.size()) : 
                allCertificates;
            
            request.setAttribute("totalCertificates", totalCertificates);
            request.setAttribute("activeCertificates", activeCertificates);
            request.setAttribute("revokedCertificates", revokedCertificates);
            request.setAttribute("recentCertificates", recentCertificates);
            
            request.getRequestDispatcher("/admin-dashboard.jsp").forward(request, response);
            
        } catch (Exception e) {
            request.setAttribute("error", "Error loading dashboard: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
    
    private void showAllCertificates(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            List<Certificate> certificates = XMLManager.getAllCertificates();
            
            // Filter by status if requested
            String statusFilter = request.getParameter("status");
            if (statusFilter != null && !statusFilter.isEmpty()) {
                certificates = certificates.stream()
                    .filter(cert -> statusFilter.equals(cert.getStatus()))
                    .collect(java.util.stream.Collectors.toList());
            }
            
            // Search functionality
            String searchQuery = request.getParameter("search");
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                String query = searchQuery.toLowerCase().trim();
                certificates = certificates.stream()
                    .filter(cert -> 
                        cert.getStudentName().toLowerCase().contains(query) ||
                        cert.getCourse().toLowerCase().contains(query) ||
                        cert.getCertificateId().toLowerCase().contains(query))
                    .collect(java.util.stream.Collectors.toList());
            }
            
            request.setAttribute("certificates", certificates);
            request.setAttribute("statusFilter", statusFilter);
            request.setAttribute("searchQuery", searchQuery);
            
            request.getRequestDispatcher("/admin-certificates.jsp").forward(request, response);
            
        } catch (Exception e) {
            request.setAttribute("error", "Error loading certificates: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
    
    private void showCertificateDetails(HttpServletRequest request, HttpServletResponse response, String certificateId) 
            throws ServletException, IOException {
        
        try {
            Certificate certificate = XMLManager.getCertificate(certificateId);
            if (certificate != null) {
                request.setAttribute("certificate", certificate);
                request.getRequestDispatcher("/admin-certificate-details.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Certificate not found");
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error loading certificate: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
    
    private void updateCertificateStatus(HttpServletRequest request, HttpServletResponse response, String certificateId) 
            throws ServletException, IOException {
        
        try {
            String newStatus = request.getParameter("status");
            
            if (newStatus == null || newStatus.trim().isEmpty()) {
                request.setAttribute("error", "Status is required");
                showCertificateDetails(request, response, certificateId);
                return;
            }
            
            // Validate status
            if (!newStatus.equals("ACTIVE") && !newStatus.equals("REVOKED") && !newStatus.equals("SUSPENDED")) {
                request.setAttribute("error", "Invalid status");
                showCertificateDetails(request, response, certificateId);
                return;
            }
            
            XMLManager.updateCertificateStatus(certificateId, newStatus);
            
            request.setAttribute("message", "Certificate status updated successfully");
            showCertificateDetails(request, response, certificateId);
            
        } catch (Exception e) {
            request.setAttribute("error", "Error updating certificate status: " + e.getMessage());
            showCertificateDetails(request, response, certificateId);
        }
    }
}