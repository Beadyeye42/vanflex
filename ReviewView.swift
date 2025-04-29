import SwiftUI

struct ReviewView: View {
    @Environment(\.dismiss) var dismiss
    @State private var rating = 0
    @State private var reviewText = ""
    @State private var selectedTags: Set<String> = []
    @State private var selectedPhotos: [UIImage] = []
    @State private var showPhotoPicker = false
    
    let reviewTags = [
        "Professional",
        "Punctual",
        "Quality Service",
        "Good Communication",
        "Value for Money",
        "Clean Work",
        "Friendly",
        "Efficient"
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
                        // Service Details
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Window Cleaning")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Text("John's Van Services")
                                .font(.headline)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(15)
                        
                        // Rating Stars
                        VStack(spacing: 15) {
                            Text("How was your experience?")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            HStack(spacing: 15) {
                                ForEach(1...5, id: \.self) { star in
                                    Image(systemName: star <= rating ? "star.fill" : "star")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(star <= rating ? .yellow : .white.opacity(0.5))
                                        .onTapGesture {
                                            rating = star
                                        }
                                }
                            }
                        }
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(15)
                        
                        // Review Tags
                        VStack(alignment: .leading, spacing: 15) {
                            Text("What went well?")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 10) {
                                ForEach(reviewTags, id: \.self) { tag in
                                    Button(action: {
                                        if selectedTags.contains(tag) {
                                            selectedTags.remove(tag)
                                        } else {
                                            selectedTags.insert(tag)
                                        }
                                    }) {
                                        HStack {
                                            Text(tag)
                                                .foregroundColor(.white)
                                            Spacer()
                                            if selectedTags.contains(tag) {
                                                Image(systemName: "checkmark.circle.fill")
                                                    .foregroundColor(.white)
                                            }
                                        }
                                        .padding()
                                        .background(selectedTags.contains(tag) ? Color.white.opacity(0.2) : Color.white.opacity(0.1))
                                        .cornerRadius(10)
                                    }
                                }
                            }
                        }
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(15)
                        
                        // Photo Upload
                        PhotoPickerView(selectedPhotos: $selectedPhotos)
                            .padding()
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(15)
                        
                        // Review Text
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Additional Comments")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            TextEditor(text: $reviewText)
                                .frame(height: 150)
                                .background(Color.white.opacity(0.1))
                                .cornerRadius(10)
                                .foregroundColor(.white)
                                .scrollContentBackground(.hidden)
                                .overlay(
                                    Group {
                                        if reviewText.isEmpty {
                                            Text("Share your experience...")
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
                        
                        // Submit Button
                        Button(action: {
                            // Handle review submission
                            dismiss()
                        }) {
                            Text("Submit Review")
                                .font(.headline)
                                .foregroundColor(.blue)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(15)
                        }
                        .padding(.horizontal)
                        .disabled(rating == 0)
                        .opacity(rating == 0 ? 0.6 : 1)
                    }
                    .padding()
                }
            }
            .navigationTitle("Write Review")
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

struct ReviewCard: View {
    let review: Review
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading) {
                    Text(review.customerName)
                        .font(.headline)
                        .foregroundColor(.white)
                    Text(review.date)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                }
                Spacer()
                
                HStack(spacing: 5) {
                    ForEach(1...5, id: \.self) { star in
                        Image(systemName: star <= review.rating ? "star.fill" : "star")
                            .foregroundColor(.yellow)
                            .font(.caption)
                    }
                }
            }
            
            if !review.tags.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(review.tags, id: \.self) { tag in
                            Text(tag)
                                .font(.caption)
                                .foregroundColor(.white)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(10)
                        }
                    }
                }
            }
            
            if !review.comment.isEmpty {
                Text(review.comment)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.9))
                    .padding(.top, 5)
            }
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(15)
    }
}

struct Review {
    let id: Int
    let customerName: String
    let rating: Int
    let tags: [String]
    let comment: String
    let date: String
}

#Preview {
    ReviewView()
} 