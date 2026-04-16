import Foundation
import SwiftUI
import Combine


import Foundation
import SwiftUI
import Combine

class MetroChatService: ObservableObject {
    private let apiKey = "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"
    private let endpoint = "https://integrate.api.nvidia.com/v1/chat/completions"
    
    @Published var messages: [AIChatMessage] = []
    @Published var isThinking = false
    
    @Published var currentAppData: String = "Пользователь открыл приложение"
    
    private var currentTask: Task<Void, Never>? = nil
    
    init() {
        let systemPrompt = AIChatMessage(
            role: "system",
            content: """
            Ты — «Дежурный по метро», официальный ИИ-помощник мобильного приложения о Московском метрополитене. Твой образ: дружелюбный, начитанный и вежливый сотрудник.
            
            ТВОИ ЗАДАЧИ:
            1. Консультировать по сериям вагонов (от «Еж3» до «Москва-2024»), истории станций и архитектуре.
            2. Использовать данные из системных сообщений о местоположении пользователя, чтобы отвечать точнее.
            
            ПРАВИЛА:
            - НИКАКОГО MARKDOWN (запрещены #, *, жирный шрифт, списки через дефис).
            - Используй эмодзи (метро, поезда, искры) 🚇✨.
            - Отвечай кратко и по делу.
            - Тебе будут приходить сообщения 'ТЕКУЩЕЕ СОСТОЯНИЕ', используй их как контекст.
            """
        )
        self.messages.append(systemPrompt)
        
        self.messages.append(AIChatMessage(
            role: "assistant",
            content: "Привет! Я твой Дежурный по метро. Помогу найти нужную станцию или расскажу интересные факты о поездах. О чем хочешь узнать? 🚇"
        ))
        
        
    }
    
    func updateContext(event: String) {
        self.currentAppData = event
    }
    
    func sendMessage(_ text: String) async {
        await MainActor.run {
            self.isThinking = true
            
            let contextMsg = AIChatMessage(role: "system", content: "ТЕКУЩЕЕ СОСТОЯНИЕ: \(currentAppData)")
            self.messages.append(contextMsg)
            
            let userMsg = AIChatMessage(role: "user", content: text)
            self.messages.append(userMsg)
        }
        
        currentTask = Task {
            var request = URLRequest(url: URL(string: endpoint)!, timeoutInterval: 60)
            request.httpMethod = "POST"
            request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let body: [String: Any] = [
                "model": "deepseek-ai/deepseek-v3.1-terminus",
                "messages": messages.suffix(12).map { ["role": $0.role, "content": $0.content] },
                "temperature": 0.3,
                "top_p": 0.7,
                "max_tokens": 1000,
                "stream": false,
                "extra_body": ["chat_template_kwargs": ["thinking": false]]
            ]
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
            
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                
                if Task.isCancelled { return }
                
                let decodedResponse = try JSONDecoder().decode(DeepSeekResponse.self, from: data)
                
                await MainActor.run {
                    if let choice = decodedResponse.choices.first {
                        self.messages.append(choice.message)
                    }
                    self.isThinking = false
                }
            } catch {
                print("Ошибка запроса: \(error)")
                await MainActor.run { self.isThinking = false }
            }
        }
    }
    
    func stopGeneration() {
        currentTask?.cancel()
        currentTask = nil
        isThinking = false
    }
}


