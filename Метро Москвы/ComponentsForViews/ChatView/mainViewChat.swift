import SwiftUI
import UIKit

struct ChatView: View {
    @StateObject var service = MetroChatService()
    @State private var messageText: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 4) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.red)
                Text("Дежурный по метро").font(.custom("moscowsansregular", size: 18)).bold()
                Text("ИИ-помощник").font(.custom("moscowsansregular", size: 12)).foregroundColor(.secondary)
            }
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
            
            Divider()

            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(service.messages.filter { $0.role != "system" }) { message in
                            ChatBubble(message: message)
                                .id(message.id)
                        }
                        
                        if service.isThinking {
                            HStack {
                                ProgressView().padding(.leading, 20)
                                Spacer()
                            }.id("thinking")
                        }
                    }
                    .padding(.vertical, 10)
                }
                .onTapGesture { hideKeyboard() }
                .onChange(of: service.messages.count) { _ in
                    withAnimation {
                        if let lastId = service.messages.last?.id {
                            proxy.scrollTo(lastId, anchor: .bottom)
                        }
                    }
                }
            }
            
            Divider()
            
            // Панель ввода
            HStack(alignment: .bottom, spacing: 12) {
                TextField(service.isThinking ? "Дежурный отвечает..." : "Сообщение...", text: $messageText, axis: .vertical)
                    .font(.custom("moscowsansregular", size: 16))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(20)
                    .lineLimit(1...5)
                    .disabled(service.isThinking)
                
                
                if service.isThinking {
                    Button(action: { service.stopGeneration() }) {
                        Image(systemName: "stop.circle.fill").resizable()
                            .frame(width: 32, height: 32).foregroundColor(.red)
                    }
                } else {
                    Button(action: {
                        let text = messageText
                        messageText = ""
                        Task { await service.sendMessage(text) }
                    }) {
                        Image(systemName: "arrow.up.circle.fill").resizable()
                            .frame(width: 32, height: 32)
                            .foregroundColor(messageText.isEmpty ? .gray : .red)
                    }
                    .disabled(messageText.isEmpty)
                }
            }
            .padding(12)
            .background(.ultraThinMaterial)
        }
        .onAppear {
            hideKeyboard()
        }
    }
}
#Preview{
    ChatView()
}
