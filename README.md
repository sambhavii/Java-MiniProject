# Certificate Generator System

A comprehensive digital certificate generation system built with Java, Servlets, JSP, and XML with QR code integration for authenticity verification.

## Features

### Certificate Creation
- **Admin Interface**: Easy-to-use forms for inputting student details (name, course, date, grade, etc.)
- **XML Storage**: All certificate details stored in structured XML format
- **Multiple Templates**: Support for Course Completion, Participation, and Excellence certificates
- **Institution Branding**: Customizable institution names and branding

### Unique Certificate ID & QR Code
- **Unique IDs**: Each certificate gets a unique identifier (CERT-timestamp-random)
- **QR Code Generation**: Automatic QR code creation linking to verification page
- **Tamper-Proof**: QR codes contain verification URLs for authenticity checking

### Template Management
- **Course Completion**: Standard completion certificates with grades
- **Participation**: Certificates for event/course participation
- **Excellence**: Special recognition certificates for outstanding performance
- **PDF Generation**: Professional PDF output with embedded QR codes

### Bulk Certificate Generation
- **Batch Processing**: Create multiple certificates at once
- **CSV-like Input**: Simple text format for student data entry
- **Efficient Processing**: Bulk generation for events or courses

### Verification Portal
- **QR Code Scanning**: Mobile-friendly QR code verification
- **Manual Verification**: Enter certificate ID for verification
- **API Support**: JSON API for programmatic verification
- **Status Checking**: Real-time certificate status validation

### Admin Dashboard
- **Statistics**: Track total, active, and revoked certificates
- **Certificate Management**: View, edit, and manage all certificates
- **Status Control**: Activate, revoke, or suspend certificates
- **Search & Filter**: Find certificates by name, course, or ID

### Security Features
- **Digital Signatures**: Simplified digital signature system
- **QR Verification**: Secure QR code-based verification
- **XML Records**: Tamper-evident XML-based record keeping
- **Status Management**: Certificate lifecycle management

## Technology Stack

- **Backend**: Java 11, Servlets 4.0, JSP 2.3
- **Build Tool**: Maven 3.x
- **PDF Generation**: iText 5.x
- **QR Code**: ZXing (Zebra Crossing)
- **Data Storage**: XML files
- **Frontend**: Bootstrap 5, Font Awesome 6
- **JSON Processing**: Jackson

## Project Structure

```
certificate-generator/
├── src/main/java/com/certificate/
│   ├── model/
│   │   └── Certificate.java          # Certificate data model
│   ├── servlet/
│   │   ├── CertificateServlet.java   # Certificate CRUD operations
│   │   ├── AdminServlet.java         # Admin dashboard functionality
│   │   ├── VerificationServlet.java  # Certificate verification
│   │   └── PDFServlet.java          # PDF generation and download
│   └── util/
│       ├── XMLManager.java          # XML data persistence
│       ├── QRCodeGenerator.java     # QR code generation
│       └── PDFGenerator.java        # PDF certificate generation
├── src/main/webapp/
│   ├── WEB-INF/
│   │   └── web.xml                  # Servlet configuration
│   ├── *.jsp                        # JSP pages for UI
│   └── index.jsp                    # Landing page
├── pom.xml                          # Maven dependencies
└── README.md                        # This file
```

## Setup Instructions

### Prerequisites
- Java 11 or higher
- Maven 3.6+
- Apache Tomcat 9.0+ or similar servlet container

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd certificate-generator
   ```

2. **Build the project**
   ```bash
   mvn clean compile
   ```

3. **Package the application**
   ```bash
   mvn package
   ```

4. **Deploy to Tomcat**
   - Copy the generated `certificate-generator.war` from `target/` directory
   - Place it in Tomcat's `webapps/` directory
   - Start Tomcat server

5. **Access the application**
   - Open browser and navigate to: `http://localhost:8080/certificate-generator`

## Usage Guide

### Creating Certificates

1. **Single Certificate**
   - Navigate to "Create Certificate" from the home page
   - Fill in student details, course information, and select template
   - Choose institution name and submit
   - Certificate is generated with unique ID and QR code

2. **Bulk Certificates**
   - Go to "Bulk Create Certificates"
   - Enter course and institution details
   - Add student data (one per line): `Name, Grade`
   - Submit to create multiple certificates at once

### Verification

1. **QR Code Verification**
   - Scan QR code on certificate using mobile device
   - Automatically redirects to verification page

2. **Manual Verification**
   - Go to "Verify Certificate" page
   - Enter certificate ID
   - View verification results

3. **API Verification**
   - Use GET request: `/verify?id=CERT_ID&format=json`
   - Returns JSON with verification status and details

### Admin Functions

1. **Dashboard**
   - View certificate statistics
   - See recent certificates
   - Quick access to all functions

2. **Certificate Management**
   - View all certificates
   - Search and filter certificates
   - Update certificate status (Active/Revoked/Suspended)

3. **PDF Downloads**
   - Download individual certificates as PDF
   - Professional formatting with QR codes
   - Print-ready quality

## API Endpoints

### Certificate Operations
- `GET /certificate/` - Create certificate form
- `POST /certificate/create` - Create new certificate
- `POST /certificate/bulk-create` - Bulk certificate creation
- `GET /certificate/list` - List all certificates
- `GET /certificate/view/{id}` - View specific certificate

### Admin Operations
- `GET /admin/dashboard` - Admin dashboard
- `GET /admin/certificates` - Manage certificates
- `GET /admin/certificate/{id}` - Certificate details
- `POST /admin/update-status/{id}` - Update certificate status

### Verification
- `GET /verify` - Verification form
- `GET /verify?id={id}` - Verify certificate (HTML)
- `GET /verify?id={id}&format=json` - Verify certificate (JSON API)

### PDF Generation
- `GET /pdf/download/{id}` - Download certificate PDF

## Configuration

### XML Storage
- Certificates are stored in `certificates.xml` in the application root
- Automatic XML file creation on first certificate generation
- Structured XML format for easy parsing and backup

### Templates
- Three built-in templates: Course Completion, Participation, Excellence
- Customizable colors and layouts in `PDFGenerator.java`
- Institution branding support

### Security
- Digital signatures using simplified hash-based approach
- QR codes contain verification URLs for authenticity
- Certificate status management for revocation

## Customization

### Adding New Templates
1. Add new template type in `Certificate.java`
2. Implement template method in `PDFGenerator.java`
3. Update JSP forms to include new template option

### Styling
- Modify Bootstrap classes in JSP files
- Customize PDF layouts in `PDFGenerator.java`
- Update CSS in JSP pages for custom styling

### Database Integration
- Replace `XMLManager.java` with database DAO
- Update servlet methods to use new data layer
- Maintain same interface for seamless integration

## Troubleshooting

### Common Issues

1. **PDF Generation Errors**
   - Ensure iText dependencies are properly loaded
   - Check file permissions for PDF creation
   - Verify QR code generation is working

2. **QR Code Issues**
   - Confirm ZXing libraries are in classpath
   - Check base URL configuration in servlets
   - Verify image encoding in JSP pages

3. **XML Storage Problems**
   - Check file write permissions
   - Ensure XML file is not corrupted
   - Verify XML parsing in XMLManager

### Performance Optimization
- Implement connection pooling for database version
- Add caching for frequently accessed certificates
- Optimize PDF generation for bulk operations

## Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/new-feature`)
3. Commit changes (`git commit -am 'Add new feature'`)
4. Push to branch (`git push origin feature/new-feature`)
5. Create Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support and questions:
- Create an issue in the repository
- Check the troubleshooting section
- Review the API documentation

## Future Enhancements
- Database integration (MySQL/PostgreSQL)
- Email certificate delivery
- Advanced template designer
- Multi-language support
- Certificate analytics and reporting
- Mobile app for verification
- Blockchain integration for enhanced security
