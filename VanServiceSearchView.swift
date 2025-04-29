import SwiftUI

struct VanServiceSearchView: View {
    @State private var searchText = ""
    @State private var selectedServiceType = "All Services"
    @State private var showFilterSheet = false
    @State private var selectedRating = "Any"
    @State private var selectedAvailability = "Any"
    @State private var selectedLocation = "Any"
    @State private var showProviderSignup = false
    
    let serviceTypes = [
        "All Services",
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
    
    let ratings = ["Any", "4.5+ Stars", "4.0+ Stars", "3.5+ Stars"]
    let availability = ["Any", "Available Now", "Available Today", "Available This Week"]
    let locations = ["Any", "Within 5 miles", "Within 10 miles", "Within 20 miles", "Within 50 miles"]
    
    // Sample data for demonstration
    let sampleDistances = [2.5, 4.8, 7.2, 3.1, 5.6]
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.blue.opacity(0.4)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Search bar and filter button
                    HStack {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.white)
                            
                            TextField("Search for van services...", text: $searchText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .colorScheme(.dark)
                        }
                        
                        Button(action: {
                            showFilterSheet = true
                        }) {
                            Image(systemName: "line.3.horizontal.decrease.circle.fill")
                                .foregroundColor(.white)
                                .font(.title2)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Service type selector
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(serviceTypes, id: \.self) { service in
                                Button(action: {
                                    selectedServiceType = service
                                }) {
                                    Text(service)
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 10)
                                        .background(
                                            selectedServiceType == service ?
                                            Color.white : Color.white.opacity(0.2)
                                        )
                                        .foregroundColor(
                                            selectedServiceType == service ?
                                            .orange : .white
                                        )
                                        .cornerRadius(20)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Results section
                    ScrollView {
                        LazyVStack(spacing: 15) {
                            ForEach(0..<5) { index in
                                VanServiceCard(distance: sampleDistances[index])
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Find Van Services")
            .navigationBarTitleDisplayMode(.large)
            .foregroundColor(.white)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showFilterSheet = true
                    }) {
                        Image(systemName: "line.3.horizontal.decrease.circle.fill")
                            .foregroundColor(.white)
                            .font(.title2)
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        // Show provider signup sheet
                        showProviderSignup = true
                    }) {
                        Text("Join Us")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
            }
            .sheet(isPresented: $showFilterSheet) {
                FilterView(
                    selectedRating: $selectedRating,
                    selectedAvailability: $selectedAvailability,
                    selectedLocation: $selectedLocation,
                    ratings: ratings,
                    availability: availability,
                    locations: locations
                )
            }
            .sheet(isPresented: $showProviderSignup) {
                ProviderSignupView()
            }
        }
    }
}

struct FilterView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedRating: String
    @Binding var selectedAvailability: String
    @Binding var selectedLocation: String
    let ratings: [String]
    let availability: [String]
    let locations: [String]
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.blue.opacity(0.4)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Location Filter
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Location")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        ForEach(locations, id: \.self) { location in
                            Button(action: {
                                selectedLocation = location
                            }) {
                                HStack {
                                    Text(location)
                                        .foregroundColor(.white)
                                    Spacer()
                                    if selectedLocation == location {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.white)
                                    }
                                }
                                .padding()
                                .background(Color.white.opacity(0.1))
                                .cornerRadius(10)
                            }
                        }
                    }
                    
                    // Rating Filter
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Minimum Rating")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        ForEach(ratings, id: \.self) { rating in
                            Button(action: {
                                selectedRating = rating
                            }) {
                                HStack {
                                    Text(rating)
                                        .foregroundColor(.white)
                                    Spacer()
                                    if selectedRating == rating {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.white)
                                    }
                                }
                                .padding()
                                .background(Color.white.opacity(0.1))
                                .cornerRadius(10)
                            }
                        }
                    }
                    
                    // Availability Filter
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Availability")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        ForEach(availability, id: \.self) { avail in
                            Button(action: {
                                selectedAvailability = avail
                            }) {
                                HStack {
                                    Text(avail)
                                        .foregroundColor(.white)
                                    Spacer()
                                    if selectedAvailability == avail {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.white)
                                    }
                                }
                                .padding()
                                .background(Color.white.opacity(0.1))
                                .cornerRadius(10)
                            }
                        }
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Filters")
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

struct VanServiceCard: View {
    let distance: Double // Distance in miles
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "van.side.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white)
                
                VStack(alignment: .leading) {
                    Text("Professional Van Service")
                        .font(.headline)
                        .foregroundColor(.white)
                    HStack {
                        Text("4.8 ★ (120 reviews)")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                        Text("•")
                            .foregroundColor(.white.opacity(0.8))
                        Text(String(format: "%.1f miles away", distance))
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                    }
                }
                
                Spacer()
                
                Button(action: {
                    // Add contact action here
                }) {
                    Text("Contact")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.white)
                        .cornerRadius(15)
                }
            }
            
            Text("Professional van services available in your area. Contact directly to discuss your needs.")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
            
            HStack {
                ForEach(["Window Cleaning", "Garden Clearance", "Man with Van"], id: \.self) { tag in
                    Text(tag)
                        .font(.caption)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.white.opacity(0.2))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

#Preview {
    VanServiceSearchView()
} 