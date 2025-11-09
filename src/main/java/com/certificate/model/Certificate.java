package com.certificate.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Certificate {
    private String certificateId;
    private String studentName;
    private String course;
    private String grade;
    private String issueDate;
    private String templateType;
    private String institutionName;
    private String qrCode;
    private String status;
    private String digitalSignature;
    
    public Certificate() {
        this.certificateId = generateCertificateId();
        this.issueDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        this.status = "ACTIVE";
    }
    
    public Certificate(String studentName, String course, String grade, String templateType, String institutionName) {
        this();
        this.studentName = studentName;
        this.course = course;
        this.grade = grade;
        this.templateType = templateType;
        this.institutionName = institutionName;
    }
    
    private String generateCertificateId() {
        return "CERT-" + System.currentTimeMillis() + "-" + (int)(Math.random() * 1000);
    }
    
    // Getters and Setters
    public String getCertificateId() { return certificateId; }
    public void setCertificateId(String certificateId) { this.certificateId = certificateId; }
    
    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }
    
    public String getCourse() { return course; }
    public void setCourse(String course) { this.course = course; }
    
    public String getGrade() { return grade; }
    public void setGrade(String grade) { this.grade = grade; }
    
    public String getIssueDate() { return issueDate; }
    public void setIssueDate(String issueDate) { this.issueDate = issueDate; }
    
    public String getTemplateType() { return templateType; }
    public void setTemplateType(String templateType) { this.templateType = templateType; }
    
    public String getInstitutionName() { return institutionName; }
    public void setInstitutionName(String institutionName) { this.institutionName = institutionName; }
    
    public String getQrCode() { return qrCode; }
    public void setQrCode(String qrCode) { this.qrCode = qrCode; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public String getDigitalSignature() { return digitalSignature; }
    public void setDigitalSignature(String digitalSignature) { this.digitalSignature = digitalSignature; }
    
    @Override
    public String toString() {
        return "Certificate{" +
                "certificateId='" + certificateId + '\'' +
                ", studentName='" + studentName + '\'' +
                ", course='" + course + '\'' +
                ", grade='" + grade + '\'' +
                ", issueDate='" + issueDate + '\'' +
                ", templateType='" + templateType + '\'' +
                ", institutionName='" + institutionName + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}