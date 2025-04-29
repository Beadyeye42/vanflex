import SwiftUI

struct DocumentHistoryView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedFilter: DocumentType? = nil
    @State private var searchText = ""
    
    // Sample data
    let documents: [Document] = [
        Document(id: 1, type: .quote, clientName: "Sarah Johnson", serviceType: "Window Cleaning", amount: "80", date: Date(), status: .pending),
        Document(id: 2, type: .invoice, clientName: "John Smith", serviceType: "Garden Clearance", amount: "150", date: Date().addingTimeInterval(-86400), status: .paid),
        Document(id: 3, type: .quote, clientName: "Emma Davis", serviceType: "House Removal", amount: "300", date: Date().addingTimeInterval(-172800), status: .accepted),
        Document(id: 4, type: .invoice, clientName: "Michael Brown", serviceType: "Man with Van", amount: "120", date: Date().addingTimeInterval(-259200), status: .overdue)
    ]
    
    var filteredDocuments: [Document] {
        documents.filter { document in
            let matchesFilter = selectedFilter == nil || document.type == selectedFilter
            let matchesSearch = searchText.isEmpty || 
                document.clientName.localizedCaseInsensitiveContains(searchText) ||
                document.serviceType.localizedCaseInsensitiveContains(searchText)
            return matchesFilter && matchesSearch
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.blue.opacity(0.4)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Search and Filter
                    VStack(spacing: 15) {
                        // Search Bar
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.white)
                            
                            TextField("Search documents...", text: $searchText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .colorScheme(.dark)
                        }
                        .padding(.horizontal)
                        
                        // Filter Buttons
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                FilterButton(title: "All", isSelected: selectedFilter == nil) {
                                    selectedFilter = nil
                                }
                                
                                FilterButton(title: "Quotes", isSelected: selectedFilter == .quote) {
                                    selectedFilter = .quote
                                }
                                
                                FilterButton(title: "Invoices", isSelected: selectedFilter == .invoice) {
                                    selectedFilter = .invoice
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                    .background(Color.white.opacity(0.1))
                    
                    // Document List
                    ScrollView {
                        LazyVStack(spacing: 15) {
                            ForEach(filteredDocuments) { document in
                                DocumentCard(document: document)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Document History")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(.white)
                }
            }
        }
    }
}

struct FilterButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(isSelected ? .blue : .white)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(isSelected ? Color.white : Color.white.opacity(0.2))
                .cornerRadius(20)
        }
    }
}

struct DocumentCard: View {
    let document: Document
    @State private var showPDF = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading) {
                    Text(document.clientName)
                        .font(.headline)
                        .foregroundColor(.white)
                    Text(document.serviceType)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                }
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("£\(document.amount)")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text(document.date, style: .date)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                }
            }
            
            HStack {
                // Document Type Badge
                Text(document.type == .quote ? "Quote" : "Invoice")
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(10)
                
                // Status Badge
                StatusBadge(status: document.status)
                
                Spacer()
                
                // Action Buttons
                Button(action: {
                    showPDF = true
                }) {
                    Image(systemName: "doc.text.fill")
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.white.opacity(0.2))
                        .clipShape(Circle())
                }
            }
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(15)
        .sheet(isPresented: $showPDF) {
            PDFViewer(document: document)
        }
    }
}

struct StatusBadge: View {
    let status: DocumentStatus
    
    var body: some View {
        Text(status.rawValue)
            .font(.caption)
            .foregroundColor(.white)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(statusColor.opacity(0.2))
            .cornerRadius(10)
    }
    
    var statusColor: Color {
        switch status {
        case .pending:
            return .yellow
        case .accepted:
            return .green
        case .paid:
            return .blue
        case .overdue:
            return .red
        }
    }
}

struct PDFViewer: View {
    @Environment(\.dismiss) var dismiss
    let document: Document
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                // PDF View would go here
                Text("PDF Viewer")
                    .foregroundColor(.white)
            }
            .navigationTitle("\(document.type == .quote ? "Quote" : "Invoice") #\(document.id)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(.white)
                }
            }
        }
    }
}

struct Document: Identifiable {
    let id: Int
    let type: DocumentType
    let clientName: String
    let serviceType: String
    let amount: String
    let date: Date
    let status: DocumentStatus
}

enum DocumentStatus: String {
    case pending = "Pending"
    case accepted = "Accepted"
    case paid = "Paid"
    case overdue = "Overdue"
}

#Preview {
    DocumentHistoryView()
} 