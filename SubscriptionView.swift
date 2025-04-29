import SwiftUI

struct SubscriptionView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isSubscribing = false
    
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
                    VStack(spacing: 30) {
                        // Free Trial Banner
                        VStack(spacing: 15) {
                            Image(systemName: "gift.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.white)
                            
                            Text("6 Months Free!")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.white)
                            
                            Text("Start your journey with us")
                                .font(.title3)
                                .foregroundColor(.white.opacity(0.9))
                        }
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(20)
                        
                        // Subscription Details
                        VStack(spacing: 20) {
                            Text("Subscription Details")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            VStack(spacing: 15) {
                                SubscriptionFeatureRow(icon: "checkmark.circle.fill", text: "6 months completely free")
                                SubscriptionFeatureRow(icon: "checkmark.circle.fill", text: "£2.99/month after trial")
                                SubscriptionFeatureRow(icon: "checkmark.circle.fill", text: "Cancel anytime")
                                SubscriptionFeatureRow(icon: "checkmark.circle.fill", text: "Full access to all features")
                                SubscriptionFeatureRow(icon: "checkmark.circle.fill", text: "Priority customer support")
                            }
                        }
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(20)
                        
                        // Subscribe Button
                        Button(action: {
                            isSubscribing = true
                            // Handle subscription logic here
                        }) {
                            Text("Start Free Trial")
                                .font(.headline)
                                .foregroundColor(.blue)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(15)
                        }
                        .padding(.horizontal)
                        
                        // Terms and Conditions
                        Text("By subscribing, you agree to our Terms of Service and Privacy Policy")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .padding()
                }
            }
            .navigationTitle("Subscription")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Close") {
                        dismiss()
                    }
                    .foregroundColor(.white)
                }
            }
        }
    }
}

struct SubscriptionFeatureRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .foregroundColor(.white)
                .font(.title3)
            
            Text(text)
                .foregroundColor(.white)
                .font(.body)
            
            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(10)
    }
}

#Preview {
    SubscriptionView()
} 