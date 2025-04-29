import SwiftUI

struct ProfessionalDocumentView: View {
    @Environment(\.dismiss) var dismiss
    @State private var documentType: DocumentType = .quote
    @State private var clientName = ""
    @State private var clientEmail = ""
    @State private var clientAddress = ""
    @State private var serviceType = ""
    @State private var description = ""
    @State private var amount = ""
    @State private var date = Date()
    @State private var dueDate = Date()
    @State private var terms = ""
    @State private var notes = ""
    @State private var showPDFPreview = false
    @State private var pdfData: Data?
    @State private var showShareSheet = false
    @State private var selectedImages: [UIImage] = []
    @State private var showPhotoAttachment = false
    
    let serviceTypes = [
        "Window Cleaning",
        "Garden Clearance",
        "Recovery Truck",
        "Mini Bus Hire",
        "Man with Van",
        "Locksmith",
        "Campervan Rentals",
        "House Removal",
        "Courier Service",
        "Mobile Tyre Service",
        "Handyman"
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.blue.opacity(0.4)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 25) {
                        // Document Type Selector
                        Picker("Document Type", selection: $documentType) {
                            Text("Quote").tag(DocumentType.quote)
                            Text("Invoice").tag(DocumentType.invoice)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal)
                        
                        // Document Preview
                        DocumentPreviewCard(
                            documentType: documentType,
                            clientName: clientName,
                            clientEmail: clientEmail,
                            clientAddress: clientAddress,
                            serviceType: serviceType,
                            description: description,
                            amount: amount,
                            date: date,
                            dueDate: dueDate,
                            terms: terms,
                            notes: notes
                        )
                        .padding(.horizontal)
                        
                        // Client Information
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Client Information")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            CustomTextField(text: $clientName, placeholder: "Client Name")
                            CustomTextField(text: $clientEmail, placeholder: "Client Email", keyboardType: .emailAddress)
                            CustomTextField(text: $clientAddress, placeholder: "Client Address")
                        }
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(15)
                        
                        // Service Details
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Service Details")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            Picker("Service Type", selection: $serviceType) {
                                Text("Select a service").tag("")
                                ForEach(serviceTypes, id: \.self) { service in
                                    Text(service).tag(service)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .padding()
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            
                            TextEditor(text: $description)
                                .frame(height: 100)
                                .background(Color.white.opacity(0.1))
                                .cornerRadius(10)
                                .foregroundColor(.white)
                                .scrollContentBackground(.hidden)
                                .overlay(
                                    Group {
                                        if description.isEmpty {
                                            Text("Service Description")
                                                .foregroundColor(.white.opacity(0.5))
                                                .padding(.leading, 5)
                                                .padding(.top, 8)
                                        }
                                    }
                                )
                            
                            CustomTextField(text: $amount, placeholder: "Amount (£)", keyboardType: .decimalPad)
                            
                            // Photo Attachment Button
                            Button(action: {
                                showPhotoAttachment = true
                            }) {
                                HStack {
                                    Image(systemName: "photo")
                                    Text("Add Photos")
                                }
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white.opacity(0.1))
                                .cornerRadius(10)
                            }
                        }
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(15)
                        
                        // Dates
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Dates")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Creation Date")
                                    .font(.subheadline)
                                    .foregroundColor(.white.opacity(0.8))
                                DatePicker("", selection: $date, displayedComponents: [.date])
                                    .datePickerStyle(GraphicalDatePickerStyle())
                                    .background(Color.white.opacity(0.1))
                                    .cornerRadius(10)
                                    .foregroundColor(.white)
                            }
                            
                            if documentType == .invoice {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Payment Due Date")
                                        .font(.subheadline)
                                        .foregroundColor(.white.opacity(0.8))
                                    DatePicker("", selection: $dueDate, displayedComponents: [.date])
                                        .datePickerStyle(GraphicalDatePickerStyle())
                                        .background(Color.white.opacity(0.1))
                                        .cornerRadius(10)
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(15)
                        
                        // Terms and Notes
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Additional Information")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            TextEditor(text: $terms)
                                .frame(height: 100)
                                .background(Color.white.opacity(0.1))
                                .cornerRadius(10)
                                .foregroundColor(.white)
                                .scrollContentBackground(.hidden)
                                .overlay(
                                    Group {
                                        if terms.isEmpty {
                                            Text("Terms and Conditions")
                                                .foregroundColor(.white.opacity(0.5))
                                                .padding(.leading, 5)
                                                .padding(.top, 8)
                                        }
                                    }
                                )
                            
                            TextEditor(text: $notes)
                                .frame(height: 100)
                                .background(Color.white.opacity(0.1))
                                .cornerRadius(10)
                                .foregroundColor(.white)
                                .scrollContentBackground(.hidden)
                                .overlay(
                                    Group {
                                        if notes.isEmpty {
                                            Text("Additional Notes")
                                                .foregroundColor(.white.opacity(0.5))
                                                .padding(.leading, 5)
                                                .padding(.top, 8)
                                        }
                                    }
                                )
                        }
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(15)
                        
                        // Action Buttons
                        HStack(spacing: 15) {
                            Button(action: {
                                if let pdfData = PDFExportService.generatePDF(
                                    documentType: documentType,
                                    clientName: clientName,
                                    clientEmail: clientEmail,
                                    clientAddress: clientAddress,
                                    serviceType: serviceType,
                                    description: description,
                                    amount: amount,
                                    date: date,
                                    dueDate: dueDate,
                                    terms: terms,
                                    notes: notes
                                ) {
                                    self.pdfData = pdfData
                                    showPDFPreview = true
                                }
                            }) {
                                Text("Preview")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(15)
                            }
                            
                            Button(action: {
                                if let pdfData = PDFExportService.generatePDF(
                                    documentType: documentType,
                                    clientName: clientName,
                                    clientEmail: clientEmail,
                                    clientAddress: clientAddress,
                                    serviceType: serviceType,
                                    description: description,
                                    amount: amount,
                                    date: date,
                                    dueDate: dueDate,
                                    terms: terms,
                                    notes: notes
                                ) {
                                    self.pdfData = pdfData
                                    showShareSheet = true
                                }
                            }) {
                                Text("Send")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(15)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding()
                }
            }
            .navigationTitle(documentType == .quote ? "Create Quote" : "Create Invoice")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.white)
                }
            }
            .sheet(isPresented: $showPDFPreview) {
                if let pdfData = pdfData {
                    PDFPreviewView(pdfData: pdfData)
                }
            }
            .sheet(isPresented: $showShareSheet) {
                if let pdfData = pdfData {
                    ShareSheet(items: [pdfData])
                }
            }
            .sheet(isPresented: $showPhotoAttachment) {
                PhotoAttachmentView(selectedImages: $selectedImages)
            }
        }
    }
}

struct DocumentPreviewCard: View {
    let documentType: DocumentType
    let clientName: String
    let clientEmail: String
    let clientAddress: String
    let serviceType: String
    let description: String
    let amount: String
    let date: Date
    let dueDate: Date
    let terms: String
    let notes: String
    
    var body: some View {
        VStack(spacing: 20) {
            // Header
            VStack(spacing: 5) {
                Text(documentType == .quote ? "QUOTE" : "INVOICE")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                Text("VanFlex")
                    .font(.headline)
                    .foregroundColor(.white.opacity(0.8))
            }
            
            // Client Info
            VStack(alignment: .leading, spacing: 5) {
                Text("Bill To:")
                    .font(.headline)
                    .foregroundColor(.white)
                Text(clientName.isEmpty ? "Client Name" : clientName)
                    .foregroundColor(.white.opacity(0.8))
                Text(clientEmail.isEmpty ? "client@email.com" : clientEmail)
                    .foregroundColor(.white.opacity(0.8))
                Text(clientAddress.isEmpty ? "Client Address" : clientAddress)
                    .foregroundColor(.white.opacity(0.8))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // Service Details
            VStack(alignment: .leading, spacing: 10) {
                Text("Service Details:")
                    .font(.headline)
                    .foregroundColor(.white)
                
                HStack {
                    Text(serviceType.isEmpty ? "Service Type" : serviceType)
                        .foregroundColor(.white.opacity(0.8))
                    Spacer()
                    Text(amount.isEmpty ? "£0.00" : "£\(amount)")
                        .foregroundColor(.white)
                }
                
                if !description.isEmpty {
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                }
            }
            
            // Dates
            HStack {
                VStack(alignment: .leading) {
                    Text("Date:")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text(date, style: .date)
                        .foregroundColor(.white.opacity(0.8))
                }
                
                if documentType == .invoice {
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("Due Date:")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text(dueDate, style: .date)
                            .foregroundColor(.white.opacity(0.8))
                    }
                }
            }
            
            // Terms and Notes
            if !terms.isEmpty || !notes.isEmpty {
                VStack(alignment: .leading, spacing: 10) {
                    if !terms.isEmpty {
                        Text("Terms:")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text(terms)
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                    }
                    
                    if !notes.isEmpty {
                        Text("Notes:")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text(notes)
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                    }
                }
            }
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(15)
    }
}

enum DocumentType {
    case quote
    case invoice
}

#Preview {
    ProfessionalDocumentView()
} 