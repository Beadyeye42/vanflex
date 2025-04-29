import SwiftUI

struct ProviderDashboardView: View {
    @State private var selectedTab = 0
    @State private var showNewQuote = false
    @State private var showNewInvoice = false
    @State private var showMessaging = false
    
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
                    // Dashboard Header
                    VStack(spacing: 15) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Welcome, John's Van Services")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Text("Active Jobs: 3")
                                    .font(.subheadline)
                                    .foregroundColor(.white.opacity(0.8))
                            }
                            Spacer()
                            
                            Button(action: {
                                showMessaging = true
                            }) {
                                Image(systemName: "message.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.white)
                            }
                        }
                        
                        // Quick Stats
                        HStack(spacing: 15) {
                            StatCard(title: "Today's Jobs", value: "2", icon: "calendar")
                            StatCard(title: "Pending Quotes", value: "5", icon: "doc.text")
                            StatCard(title: "Unpaid Invoices", value: "3", icon: "pound.circle")
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))
                    
                    // Main Content
                    TabView(selection: $selectedTab) {
                        // Jobs Tab
                        JobsView()
                            .tabItem {
                                Image(systemName: "list.bullet")
                                Text("Jobs")
                            }
                            .tag(0)
                        
                        // Quotes Tab
                        QuotesView()
                            .tabItem {
                                Image(systemName: "doc.text")
                                Text("Quotes")
                            }
                            .tag(1)
                        
                        // Invoices Tab
                        InvoicesView()
                            .tabItem {
                                Image(systemName: "pound.circle")
                                Text("Invoices")
                            }
                            .tag(2)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button(action: { showNewQuote = true }) {
                            Label("New Quote", systemImage: "doc.text")
                        }
                        Button(action: { showNewInvoice = true }) {
                            Label("New Invoice", systemImage: "pound.circle")
                        }
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.white)
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $showNewQuote) {
                ProfessionalDocumentView()
            }
            .sheet(isPresented: $showNewInvoice) {
                ProfessionalDocumentView()
            }
            .sheet(isPresented: $showMessaging) {
                MessagingView()
            }
        }
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.white)
                Text(title)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
            }
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(15)
    }
}

struct JobsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                ForEach(0..<3) { _ in
                    JobCard()
                }
            }
            .padding()
        }
    }
}

struct JobCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Window Cleaning")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("123 Main Street")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                }
                Spacer()
                Text("Today")
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(10)
            }
            
            HStack {
                Button(action: {}) {
                    Text("View Details")
                        .font(.caption)
                        .foregroundColor(.blue)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 8)
                        .background(Color.white)
                        .cornerRadius(10)
                }
                
                Spacer()
                
                Button(action: {}) {
                    Text("Message")
                        .font(.caption)
                        .foregroundColor(.blue)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 8)
                        .background(Color.white)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(15)
    }
}

struct QuotesView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                ForEach(0..<5) { _ in
                    QuoteCard()
                }
            }
            .padding()
        }
    }
}

struct QuoteCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Garden Clearance")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("Client: Sarah Johnson")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                }
                Spacer()
                Text("£150")
                    .font(.headline)
                    .foregroundColor(.white)
            }
            
            Text("Pending")
                .font(.caption)
                .foregroundColor(.white)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color.white.opacity(0.2))
                .cornerRadius(10)
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(15)
    }
}

struct InvoicesView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                ForEach(0..<3) { _ in
                    InvoiceCard()
                }
            }
            .padding()
        }
    }
}

struct InvoiceCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading) {
                    Text("House Removal")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("Invoice #1234")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                }
                Spacer()
                Text("£300")
                    .font(.headline)
                    .foregroundColor(.white)
            }
            
            HStack {
                Text("Unpaid")
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(10)
                
                Spacer()
                
                Button(action: {}) {
                    Text("Send Reminder")
                        .font(.caption)
                        .foregroundColor(.blue)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 8)
                        .background(Color.white)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(15)
    }
}

struct NewQuoteView: View {
    @Environment(\.dismiss) var dismiss
    @State private var clientName = ""
    @State private var serviceType = ""
    @State private var amount = ""
    @State private var description = ""
    
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
                    VStack(spacing: 20) {
                        CustomTextField(text: $clientName, placeholder: "Client Name")
                        CustomTextField(text: $serviceType, placeholder: "Service Type")
                        CustomTextField(text: $amount, placeholder: "Amount (£)", keyboardType: .decimalPad)
                        
                        TextEditor(text: $description)
                            .frame(height: 100)
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .scrollContentBackground(.hidden)
                            .overlay(
                                Group {
                                    if description.isEmpty {
                                        Text("Description")
                                            .foregroundColor(.white.opacity(0.5))
                                            .padding(.leading, 5)
                                            .padding(.top, 8)
                                    }
                                }
                            )
                        
                        Button(action: {
                            // Handle quote creation
                            dismiss()
                        }) {
                            Text("Create Quote")
                                .font(.headline)
                                .foregroundColor(.blue)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(15)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("New Quote")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.white)
                }
            }
        }
    }
}

struct NewInvoiceView: View {
    @Environment(\.dismiss) var dismiss
    @State private var clientName = ""
    @State private var serviceType = ""
    @State private var amount = ""
    @State private var description = ""
    
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
                    VStack(spacing: 20) {
                        CustomTextField(text: $clientName, placeholder: "Client Name")
                        CustomTextField(text: $serviceType, placeholder: "Service Type")
                        CustomTextField(text: $amount, placeholder: "Amount (£)", keyboardType: .decimalPad)
                        
                        TextEditor(text: $description)
                            .frame(height: 100)
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .scrollContentBackground(.hidden)
                            .overlay(
                                Group {
                                    if description.isEmpty {
                                        Text("Description")
                                            .foregroundColor(.white.opacity(0.5))
                                            .padding(.leading, 5)
                                            .padding(.top, 8)
                                    }
                                }
                            )
                        
                        Button(action: {
                            // Handle invoice creation
                            dismiss()
                        }) {
                            Text("Create Invoice")
                                .font(.headline)
                                .foregroundColor(.blue)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(15)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("New Invoice")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.white)
                }
            }
        }
    }
}

#Preview {
    ProviderDashboardView()
} 