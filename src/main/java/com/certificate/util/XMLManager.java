package com.certificate.util;

import com.certificate.model.Certificate;
import org.w3c.dom.*;
import javax.xml.parsers.*;
import javax.xml.transform.*;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.io.*;
import java.util.*;

public class XMLManager {
    private static final String XML_FILE_PATH = "certificates.xml";
    private static final String ROOT_ELEMENT = "certificates";
    
    public static void saveCertificate(Certificate certificate) throws Exception {
        Document doc = getOrCreateDocument();
        Element root = doc.getDocumentElement();
        
        Element certElement = doc.createElement("certificate");
        certElement.setAttribute("id", certificate.getCertificateId());
        
        addElement(doc, certElement, "studentName", certificate.getStudentName());
        addElement(doc, certElement, "course", certificate.getCourse());
        addElement(doc, certElement, "grade", certificate.getGrade());
        addElement(doc, certElement, "issueDate", certificate.getIssueDate());
        addElement(doc, certElement, "templateType", certificate.getTemplateType());
        addElement(doc, certElement, "institutionName", certificate.getInstitutionName());
        addElement(doc, certElement, "qrCode", certificate.getQrCode());
        addElement(doc, certElement, "status", certificate.getStatus());
        addElement(doc, certElement, "digitalSignature", certificate.getDigitalSignature());
        
        root.appendChild(certElement);
        saveDocument(doc);
    }
    
    public static Certificate getCertificate(String certificateId) throws Exception {
        Document doc = getDocument();
        if (doc == null) return null;
        
        NodeList certificates = doc.getElementsByTagName("certificate");
        for (int i = 0; i < certificates.getLength(); i++) {
            Element certElement = (Element) certificates.item(i);
            if (certificateId.equals(certElement.getAttribute("id"))) {
                return createCertificateFromElement(certElement);
            }
        }
        return null;
    }
    
    public static List<Certificate> getAllCertificates() throws Exception {
        List<Certificate> certificates = new ArrayList<>();
        Document doc = getDocument();
        if (doc == null) return certificates;
        
        NodeList certNodes = doc.getElementsByTagName("certificate");
        for (int i = 0; i < certNodes.getLength(); i++) {
            Element certElement = (Element) certNodes.item(i);
            certificates.add(createCertificateFromElement(certElement));
        }
        return certificates;
    }
    
    public static void updateCertificateStatus(String certificateId, String status) throws Exception {
        Document doc = getDocument();
        if (doc == null) return;
        
        NodeList certificates = doc.getElementsByTagName("certificate");
        for (int i = 0; i < certificates.getLength(); i++) {
            Element certElement = (Element) certificates.item(i);
            if (certificateId.equals(certElement.getAttribute("id"))) {
                NodeList statusNodes = certElement.getElementsByTagName("status");
                if (statusNodes.getLength() > 0) {
                    statusNodes.item(0).setTextContent(status);
                    saveDocument(doc);
                    break;
                }
            }
        }
    }
    
    private static Document getOrCreateDocument() throws Exception {
        File xmlFile = new File(XML_FILE_PATH);
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        
        if (xmlFile.exists()) {
            return builder.parse(xmlFile);
        } else {
            Document doc = builder.newDocument();
            Element root = doc.createElement(ROOT_ELEMENT);
            doc.appendChild(root);
            return doc;
        }
    }
    
    private static Document getDocument() throws Exception {
        File xmlFile = new File(XML_FILE_PATH);
        if (!xmlFile.exists()) return null;
        
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        return builder.parse(xmlFile);
    }
    
    private static void saveDocument(Document doc) throws Exception {
        TransformerFactory transformerFactory = TransformerFactory.newInstance();
        Transformer transformer = transformerFactory.newTransformer();
        transformer.setOutputProperty(OutputKeys.INDENT, "yes");
        transformer.setOutputProperty("{http://xml.apache.org/xslt}indent-amount", "2");
        
        DOMSource source = new DOMSource(doc);
        StreamResult result = new StreamResult(new File(XML_FILE_PATH));
        transformer.transform(source, result);
    }
    
    private static void addElement(Document doc, Element parent, String tagName, String textContent) {
        Element element = doc.createElement(tagName);
        element.setTextContent(textContent != null ? textContent : "");
        parent.appendChild(element);
    }
    
    private static Certificate createCertificateFromElement(Element element) {
        Certificate cert = new Certificate();
        cert.setCertificateId(element.getAttribute("id"));
        cert.setStudentName(getElementText(element, "studentName"));
        cert.setCourse(getElementText(element, "course"));
        cert.setGrade(getElementText(element, "grade"));
        cert.setIssueDate(getElementText(element, "issueDate"));
        cert.setTemplateType(getElementText(element, "templateType"));
        cert.setInstitutionName(getElementText(element, "institutionName"));
        cert.setQrCode(getElementText(element, "qrCode"));
        cert.setStatus(getElementText(element, "status"));
        cert.setDigitalSignature(getElementText(element, "digitalSignature"));
        return cert;
    }
    
    private static String getElementText(Element parent, String tagName) {
        NodeList nodes = parent.getElementsByTagName(tagName);
        return nodes.getLength() > 0 ? nodes.item(0).getTextContent() : "";
    }
}