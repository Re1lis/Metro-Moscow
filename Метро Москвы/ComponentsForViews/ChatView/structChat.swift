import SwiftUI

struct DeepSeekResponse: Codable {
    struct Choice: Codable {
        let message: AIChatMessage
        let finish_reason: String?
    }
    let choices: [Choice]
}

struct AIChatMessage: Codable, Identifiable {
    var id = UUID()
    let role: String
    let content: String
    let reasoning_content: String?

    enum CodingKeys: String, CodingKey {
        case role, content, reasoning_content
    }
    
    init(role: String, content: String, reasoning_content: String? = nil) {
        self.role = role
        self.content = content
        self.reasoning_content = reasoning_content
    }
}
