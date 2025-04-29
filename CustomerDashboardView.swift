import SwiftUI

struct CustomerDashboardView: View {
    @State private var selectedTab = 0
    @State private var showNewRequest = false
    
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
                                Text("Welcome, Sarah")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Text("Your Services")
                                    .font(.subheadline)
                                    .foregroundColor(.white.opacity(0.8))
                            }
                            Spacer()
                            
                            Button(action: {
                                // Handle profile action
                            }) {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.white)
                            }
                        }
                        
                        // Quick Stats
                        HStack(spacing: 15) {
                            StatCard(title: "Active Requests", value: "2", icon: "clock")
                            StatCard(title: "Saved Providers", value: "5", icon: "star")
                            StatCard(title: "Service History", value: "8", icon: "list.bullet")
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))
                    
                    // Main Content
                    TabView(selection: $selectedTab) {
                        // Active Requests Tab
                        ActiveRequestsView()
                            .tabItem {
                                Image(systemName: "clock")
                                Text("Active")
                            }
                            .tag(0)
                        
                        // Saved Providers Tab
                        SavedProvidersView()
                            .tabItem {
                                Image(systemName: "star")
                                Text("Providers")
                            }
                            .tag(1)
                        
                        // History Tab
                        ServiceHistoryView()
                            .tabItem {
                                Image(systemName: "list.bullet")
                                Text("History")
                            }
                            .tag(2)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showNewRequest = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.white)
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $showNewRequest) {
                NewServiceRequestView()
            }
        }
    }
}

struct ActiveRequestsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                ForEach(0..<2) { _ in
                    ServiceRequestCard()
                }
            }
            .padding()
        }
    }
}

struct ServiceRequestCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Window Cleaning")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("John's Van Services")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                }
                Spacer()
                Text("In Progress")
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

struct SavedProvidersView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                ForEach(0..<5) { _ in
                    ProviderCard()
                }
            }
            .padding()
        }
    }
}

struct ProviderCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading) {
                    Text("John's Van Services")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("4.8 ★ (120 reviews)")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                }
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }
            }
            
            Text("Window Cleaning, Garden Clearance, Man with Van")
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
            
            HStack {
                Button(action: {}) {
                    Text("Request Service")
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

struct ServiceHistoryView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                ForEach(0..<8) { _ in
                    HistoryCard()
                }
            }
            .padding()
        }
    }
}

struct HistoryCard: View {
    @State private var showReview = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Garden Clearance")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("John's Van Services")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                }
                Spacer()
                Text("Completed")
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
                
                Button(action: {
                    showReview = true
                }) {
                    Text("Leave Review")
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
        .sheet(isPresented: $showReview) {
            ReviewView()
        }
    }
}

struct NewServiceRequestView: View {
    @Environment(\.dismiss) var dismiss
    @State private var serviceType = ""
    @State private var description = ""
    @State private var preferredDate = Date()
    @State private var address = ""
    
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
                    VStack(spacing: 20) {
                        // Service Type
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Service Type")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            Picker("Select Service", selection: $serviceType) {
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
                        }
                        
                        // Description
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Description")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            TextEditor(text: $description)
                                .frame(height: 100)
                                .background(Color.white.opacity(0.1))
                                .cornerRadius(10)
                                .foregroundColor(.white)
                                .scrollContentBackground(.hidden)
                        }
                        
                        // Preferred Date
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Preferred Date")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            DatePicker("", selection: $preferredDate, displayedComponents: [.date])
                                .datePickerStyle(GraphicalDatePickerStyle())
                                .background(Color.white.opacity(0.1))
                                .cornerRadius(10)
                                .foregroundColor(.white)
                        }
                        
                        // Address
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Service Address")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            TextField("Enter address", text: $address)
                                .padding()
                                .background(Color.white.opacity(0.1))
                                .cornerRadius(10)
                                .foregroundColor(.white)
                        }
                        
                        // Submit Button
                        Button(action: {
                            // Handle service request submission
                            dismiss()
                        }) {
                            Text("Submit Request")
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
            .navigationTitle("New Service Request")
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
    CustomerDashboardView()
} 