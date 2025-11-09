package com.certificate.util;

import com.certificate.model.Certificate;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import javax.imageio.ImageIO;

public class PDFGenerator {
    
    public static byte[] generateCertificatePDF(Certificate certificate, String baseUrl) throws Exception {
        Document document = new Document(PageSize.A4.rotate());
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        PdfWriter writer = PdfWriter.getInstance(document, baos);
        
        document.open();
        
        // Add certificate content based on template type
        switch (certificate.getTemplateType().toUpperCase()) {
            case "COURSE_COMPLETION":
                addCourseCompletionTemplate(document, certificate, baseUrl);
                break;
            case "PARTICIPATION":
                addParticipationTemplate(document, certificate, baseUrl);
                break;
            case "EXCELLENCE":
                addExcellenceTemplate(document, certificate, baseUrl);
                break;
            default:
                addDefaultTemplate(document, certificate, baseUrl);
        }
        
        document.close();
        return baos.toByteArray();
    }
    
    private static void addCourseCompletionTemplate(Document document, Certificate certificate, String baseUrl) throws Exception {
        // Title
        Font titleFont = new Font(Font.FontFamily.HELVETICA, 28, Font.BOLD, BaseColor.DARK_GRAY);
        Paragraph title = new Paragraph("CERTIFICATE OF COMPLETION", titleFont);
        title.setAlignment(Element.ALIGN_CENTER);
        title.setSpacingAfter(30);
        document.add(title);
        
        // Institution name
        Font institutionFont = new Font(Font.FontFamily.HELVETICA, 16, Font.NORMAL, BaseColor.BLUE);
        Paragraph institution = new Paragraph(certificate.getInstitutionName(), institutionFont);
        institution.setAlignment(Element.ALIGN_CENTER);
        institution.setSpacingAfter(40);
        document.add(institution);
        
        // Certificate content
        Font contentFont = new Font(Font.FontFamily.HELVETICA, 14, Font.NORMAL);
        document.add(new Paragraph("This is to certify that", contentFont));
        document.add(Chunk.NEWLINE);
        
        Font nameFont = new Font(Font.FontFamily.HELVETICA, 20, Font.BOLD, BaseColor.BLACK);
        Paragraph studentName = new Paragraph(certificate.getStudentName(), nameFont);
        studentName.setAlignment(Element.ALIGN_CENTER);
        studentName.setSpacingBefore(10);
        studentName.setSpacingAfter(10);
        document.add(studentName);
        
        document.add(new Paragraph("has successfully completed the course", contentFont));
        document.add(Chunk.NEWLINE);
        
        Font courseFont = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD, BaseColor.DARK_GRAY);
        Paragraph courseName = new Paragraph(certificate.getCourse(), courseFont);
        courseName.setAlignment(Element.ALIGN_CENTER);
        courseName.setSpacingBefore(10);
        courseName.setSpacingAfter(20);
        document.add(courseName);
        
        if (certificate.getGrade() != null && !certificate.getGrade().isEmpty()) {
            Paragraph grade = new Paragraph("Grade: " + certificate.getGrade(), contentFont);
            grade.setAlignment(Element.ALIGN_CENTER);
            document.add(grade);
        }
        
        // Date and Certificate ID
        document.add(Chunk.NEWLINE);
        document.add(new Paragraph("Date of Issue: " + certificate.getIssueDate(), contentFont));
        document.add(new Paragraph("Certificate ID: " + certificate.getCertificateId(), contentFont));
        
        // Add QR Code
        addQRCodeToPDF(document, certificate, baseUrl);
    }
    
    private static void addParticipationTemplate(Document document, Certificate certificate, String baseUrl) throws Exception {
        Font titleFont = new Font(Font.FontFamily.HELVETICA, 26, Font.BOLD, BaseColor.GREEN);
        Paragraph title = new Paragraph("CERTIFICATE OF PARTICIPATION", titleFont);
        title.setAlignment(Element.ALIGN_CENTER);
        title.setSpacingAfter(30);
        document.add(title);
        
        Font institutionFont = new Font(Font.FontFamily.HELVETICA, 16, Font.NORMAL, BaseColor.BLUE);
        Paragraph institution = new Paragraph(certificate.getInstitutionName(), institutionFont);
        institution.setAlignment(Element.ALIGN_CENTER);
        institution.setSpacingAfter(40);
        document.add(institution);
        
        Font contentFont = new Font(Font.FontFamily.HELVETICA, 14, Font.NORMAL);
        document.add(new Paragraph("This certifies that", contentFont));
        document.add(Chunk.NEWLINE);
        
        Font nameFont = new Font(Font.FontFamily.HELVETICA, 20, Font.BOLD, BaseColor.BLACK);
        Paragraph studentName = new Paragraph(certificate.getStudentName(), nameFont);
        studentName.setAlignment(Element.ALIGN_CENTER);
        studentName.setSpacingBefore(10);
        studentName.setSpacingAfter(10);
        document.add(studentName);
        
        document.add(new Paragraph("has actively participated in", contentFont));
        document.add(Chunk.NEWLINE);
        
        Font courseFont = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD, BaseColor.DARK_GRAY);
        Paragraph courseName = new Paragraph(certificate.getCourse(), courseFont);
        courseName.setAlignment(Element.ALIGN_CENTER);
        courseName.setSpacingBefore(10);
        courseName.setSpacingAfter(20);
        document.add(courseName);
        
        document.add(Chunk.NEWLINE);
        document.add(new Paragraph("Date of Issue: " + certificate.getIssueDate(), contentFont));
        document.add(new Paragraph("Certificate ID: " + certificate.getCertificateId(), contentFont));
        
        addQRCodeToPDF(document, certificate, baseUrl);
    }
    
    private static void addExcellenceTemplate(Document document, Certificate certificate, String baseUrl) throws Exception {
        Font titleFont = new Font(Font.FontFamily.HELVETICA, 28, Font.BOLD, BaseColor.RED);
        Paragraph title = new Paragraph("CERTIFICATE OF EXCELLENCE", titleFont);
        title.setAlignment(Element.ALIGN_CENTER);
        title.setSpacingAfter(30);
        document.add(title);
        
        Font institutionFont = new Font(Font.FontFamily.HELVETICA, 16, Font.NORMAL, BaseColor.BLUE);
        Paragraph institution = new Paragraph(certificate.getInstitutionName(), institutionFont);
        institution.setAlignment(Element.ALIGN_CENTER);
        institution.setSpacingAfter(40);
        document.add(institution);
        
        Font contentFont = new Font(Font.FontFamily.HELVETICA, 14, Font.NORMAL);
        document.add(new Paragraph("This certificate is awarded to", contentFont));
        document.add(Chunk.NEWLINE);
        
        Font nameFont = new Font(Font.FontFamily.HELVETICA, 22, Font.BOLD, BaseColor.BLACK);
        Paragraph studentName = new Paragraph(certificate.getStudentName(), nameFont);
        studentName.setAlignment(Element.ALIGN_CENTER);
        studentName.setSpacingBefore(10);
        studentName.setSpacingAfter(10);
        document.add(studentName);
        
        document.add(new Paragraph("for demonstrating excellence in", contentFont));
        document.add(Chunk.NEWLINE);
        
        Font courseFont = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD, BaseColor.DARK_GRAY);
        Paragraph courseName = new Paragraph(certificate.getCourse(), courseFont);
        courseName.setAlignment(Element.ALIGN_CENTER);
        courseName.setSpacingBefore(10);
        courseName.setSpacingAfter(20);
        document.add(courseName);
        
        if (certificate.getGrade() != null && !certificate.getGrade().isEmpty()) {
            Font gradeFont = new Font(Font.FontFamily.HELVETICA, 16, Font.BOLD, BaseColor.RED);
            Paragraph grade = new Paragraph("Grade: " + certificate.getGrade(), gradeFont);
            grade.setAlignment(Element.ALIGN_CENTER);
            document.add(grade);
        }
        
        document.add(Chunk.NEWLINE);
        document.add(new Paragraph("Date of Issue: " + certificate.getIssueDate(), contentFont));
        document.add(new Paragraph("Certificate ID: " + certificate.getCertificateId(), contentFont));
        
        addQRCodeToPDF(document, certificate, baseUrl);
    }
    
    private static void addDefaultTemplate(Document document, Certificate certificate, String baseUrl) throws Exception {
        addCourseCompletionTemplate(document, certificate, baseUrl);
    }
    
    private static void addQRCodeToPDF(Document document, Certificate certificate, String baseUrl) throws Exception {
        try {
            BufferedImage qrImage = QRCodeGenerator.generateQRCodeImage(certificate.getCertificateId(), baseUrl);
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            ImageIO.write(qrImage, "PNG", baos);
            
            Image qrCodeImage = Image.getInstance(baos.toByteArray());
            qrCodeImage.scaleToFit(100, 100);
            qrCodeImage.setAlignment(Element.ALIGN_RIGHT);
            qrCodeImage.setAbsolutePosition(450, 50);
            
            document.add(qrCodeImage);
            
            // Add QR code label
            Font qrFont = new Font(Font.FontFamily.HELVETICA, 8, Font.NORMAL);
            Paragraph qrLabel = new Paragraph("Scan to verify", qrFont);
            qrLabel.setAlignment(Element.ALIGN_RIGHT);
            document.add(qrLabel);
            
        } catch (Exception e) {
            System.err.println("Error adding QR code to PDF: " + e.getMessage());
        }
    }
}