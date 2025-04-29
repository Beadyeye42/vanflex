import SwiftUI
import PDFKit

class PDFExportService {
    static func generatePDF(documentType: DocumentType,
                          clientName: String,
                          clientEmail: String,
                          clientAddress: String,
                          serviceType: String,
                          description: String,
                          amount: String,
                          date: Date,
                          dueDate: Date,
                          terms: String,
                          notes: String) -> Data? {
        
        let pageWidth: CGFloat = 595.0  // A4 width in points
        let pageHeight: CGFloat = 842.0 // A4 height in points
        let margin: CGFloat = 50.0
        
        let pdfMetaData = [
            kCGPDFContextCreator: "VanFlex",
            kCGPDFContextAuthor: "VanFlex",
            kCGPDFContextTitle: documentType == .quote ? "Quote" : "Invoice"
        ]
        
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]
        
        let renderer = UIGraphicsPDFRenderer(
            bounds: CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight),
            format: format
        )
        
        let data = renderer.pdfData { context in
            context.beginPage()
            
            // Draw header
            let headerFont = UIFont.boldSystemFont(ofSize: 24)
            let headerAttributes: [NSAttributedString.Key: Any] = [
                .font: headerFont,
                .foregroundColor: UIColor.black
            ]
            
            let headerText = documentType == .quote ? "QUOTE" : "INVOICE"
            headerText.draw(at: CGPoint(x: margin, y: margin), withAttributes: headerAttributes)
            
            // Draw company info
            let companyFont = UIFont.systemFont(ofSize: 12)
            let companyAttributes: [NSAttributedString.Key: Any] = [
                .font: companyFont,
                .foregroundColor: UIColor.black
            ]
            
            "VanFlex".draw(at: CGPoint(x: margin, y: margin + 30), withAttributes: companyAttributes)
            
            // Draw client info
            let clientFont = UIFont.boldSystemFont(ofSize: 14)
            let clientAttributes: [NSAttributedString.Key: Any] = [
                .font: clientFont,
                .foregroundColor: UIColor.black
            ]
            
            "Bill To:".draw(at: CGPoint(x: margin, y: margin + 80), withAttributes: clientAttributes)
            
            let clientInfoFont = UIFont.systemFont(ofSize: 12)
            let clientInfoAttributes: [NSAttributedString.Key: Any] = [
                .font: clientInfoFont,
                .foregroundColor: UIColor.black
            ]
            
            clientName.draw(at: CGPoint(x: margin, y: margin + 100), withAttributes: clientInfoAttributes)
            clientEmail.draw(at: CGPoint(x: margin, y: margin + 115), withAttributes: clientInfoAttributes)
            clientAddress.draw(at: CGPoint(x: margin, y: margin + 130), withAttributes: clientInfoAttributes)
            
            // Draw service details
            "Service Details:".draw(at: CGPoint(x: margin, y: margin + 180), withAttributes: clientAttributes)
            
            let serviceDetails = "\(serviceType) - £\(amount)"
            serviceDetails.draw(at: CGPoint(x: margin, y: margin + 200), withAttributes: clientInfoAttributes)
            
            if !description.isEmpty {
                description.draw(at: CGPoint(x: margin, y: margin + 215), withAttributes: clientInfoAttributes)
            }
            
            // Draw dates
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            
            "Date: \(dateFormatter.string(from: date))".draw(
                at: CGPoint(x: margin, y: margin + 260),
                withAttributes: clientInfoAttributes
            )
            
            if documentType == .invoice {
                "Due Date: \(dateFormatter.string(from: dueDate))".draw(
                    at: CGPoint(x: margin, y: margin + 275),
                    withAttributes: clientInfoAttributes
                )
            }
            
            // Draw terms and notes
            if !terms.isEmpty {
                "Terms:".draw(at: CGPoint(x: margin, y: margin + 320), withAttributes: clientAttributes)
                terms.draw(at: CGPoint(x: margin, y: margin + 340), withAttributes: clientInfoAttributes)
            }
            
            if !notes.isEmpty {
                "Notes:".draw(at: CGPoint(x: margin, y: margin + 380), withAttributes: clientAttributes)
                notes.draw(at: CGPoint(x: margin, y: margin + 400), withAttributes: clientInfoAttributes)
            }
            
            // Draw footer
            let footerText = "Thank you for choosing VanFlex"
            let footerAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 10),
                .foregroundColor: UIColor.gray
            ]
            
            footerText.draw(
                at: CGPoint(x: margin, y: pageHeight - margin),
                withAttributes: footerAttributes
            )
        }
        
        return data
    }
} 