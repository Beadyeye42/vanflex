import SwiftUI

struct MessagingView: View {
    @Environment(\.dismiss) var dismiss
    @State private var messageText = ""
    @State private var messages: [Message] = [
        Message(id: 1, content: "Hi, I need a quote for window cleaning", isFromProvider: false, timestamp: Date()),
        Message(id: 2, content: "Hello! I'd be happy to help. Could you tell me how many windows and what type of property?", isFromProvider: true, timestamp: Date()),
        Message(id: 3, content: "It's a 3-bedroom house with 8 windows", isFromProvider: false, timestamp: Date()),
        Message(id: 4, content: "Thanks! I can offer £80 for a complete window cleaning service. Would you like me to send a formal quote?", isFromProvider: true, timestamp: Date())
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
                
                VStack {
                    // Chat Header
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Sarah Johnson")
                                .font(.headline)
                                .foregroundColor(.white)
                            Text("Window Cleaning")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        Spacer()
                        
                        Button(action: {
                            // Handle quote creation
                        }) {
                            Text("Send Quote")
                                .font(.caption)
                                .foregroundColor(.blue)
                                .padding(.horizontal, 15)
                                .padding(.vertical, 8)
                                .background(Color.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))
                    
                    // Messages
                    ScrollView {
                        LazyVStack(spacing: 15) {
                            ForEach(messages) { message in
                                MessageBubble(message: message)
                            }
                        }
                        .padding()
                    }
                    
                    // Message Input
                    HStack {
                        TextField("Type a message...", text: $messageText)
                            .padding()
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(20)
                            .foregroundColor(.white)
                        
                        Button(action: {
                            if !messageText.isEmpty {
                                let newMessage = Message(
                                    id: messages.count + 1,
                                    content: messageText,
                                    isFromProvider: true,
                                    timestamp: Date()
                                )
                                messages.append(newMessage)
                                messageText = ""
                            }
                        }) {
                            Image(systemName: "paperplane.fill")
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color.white.opacity(0.2))
                                .clipShape(Circle())
                        }
                    }
                    .padding()
                }
            }
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

struct Message: Identifiable {
    let id: Int
    let content: String
    let isFromProvider: Bool
    let timestamp: Date
}

struct MessageBubble: View {
    let message: Message
    
    var body: some View {
        HStack {
            if message.isFromProvider {
                Spacer()
            }
            
            VStack(alignment: message.isFromProvider ? .trailing : .leading) {
                Text(message.content)
                    .padding()
                    .background(message.isFromProvider ? Color.white : Color.white.opacity(0.2))
                    .foregroundColor(message.isFromProvider ? .blue : .white)
                    .cornerRadius(20)
                
                Text(formatTimestamp(message.timestamp))
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.6))
                    .padding(.horizontal, 5)
            }
            
            if !message.isFromProvider {
                Spacer()
            }
        }
    }
    
    private func formatTimestamp(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

#Preview {
    MessagingView()
} 