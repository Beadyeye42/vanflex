import SwiftUI

struct ProviderSignupView: View {
    @Environment(\.dismiss) var dismiss
    @State private var businessName = ""
    @State private var contactName = ""
    @State private var phoneNumber = ""
    @State private var email = ""
    @State private var address = ""
    @State private var selectedServices: Set<String> = []
    @State private var description = ""
    @State private var showSubscription = false
    
    let availableServices = [
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
                        // Business Information
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Business Information")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            CustomTextField(text: $businessName, placeholder: "Business Name")
                            CustomTextField(text: $contactName, placeholder: "Contact Name")
                            CustomTextField(text: $phoneNumber, placeholder: "Phone Number", keyboardType: .phonePad)
                            CustomTextField(text: $email, placeholder: "Email", keyboardType: .emailAddress)
                            CustomTextField(text: $address, placeholder: "Address")
                        }
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(15)
                        
                        // Services
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Services Provided")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 10) {
                                ForEach(availableServices, id: \.self) { service in
                                    Button(action: {
                                        if selectedServices.contains(service) {
                                            selectedServices.remove(service)
                                        } else {
                                            selectedServices.insert(service)
                                        }
                                    }) {
                                        HStack {
                                            Text(service)
                                                .foregroundColor(.white)
                                            Spacer()
                                            if selectedServices.contains(service) {
                                                Image(systemName: "checkmark.circle.fill")
                                                    .foregroundColor(.white)
                                            }
                                        }
                                        .padding()
                                        .background(selectedServices.contains(service) ? Color.white.opacity(0.2) : Color.white.opacity(0.1))
                                        .cornerRadius(10)
                                    }
                                }
                            }
                        }
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(15)
                        
                        // Description
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Business Description")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            TextEditor(text: $description)
                                .frame(height: 100)
                                .background(Color.white.opacity(0.1))
                                .cornerRadius(10)
                                .foregroundColor(.white)
                                .scrollContentBackground(.hidden)
                        }
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(15)
                        
                        // Submit Button
                        Button(action: {
                            // Validate form
                            if !businessName.isEmpty && !contactName.isEmpty && !phoneNumber.isEmpty && !email.isEmpty && !address.isEmpty && !selectedServices.isEmpty {
                                showSubscription = true
                            }
                        }) {
                            Text("Submit Application")
                                .font(.headline)
                                .foregroundColor(.blue)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(15)
                        }
                        .padding(.horizontal)
                    }
                    .padding()
                }
            }
            .navigationTitle("Join as Provider")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.white)
                }
            }
            .sheet(isPresented: $showSubscription) {
                SubscriptionView()
            }
        }
    }
}

struct CustomTextField: View {
    @Binding var text: String
    let placeholder: String
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        TextField(placeholder, text: $text)
            .keyboardType(keyboardType)
            .padding()
            .background(Color.white.opacity(0.1))
            .cornerRadius(10)
            .foregroundColor(.white)
            .accentColor(.white)
    }
}

#Preview {
    ProviderSignupView()
} 