//
//  NetworkResponse.swift
//  Messenger
//
//  Created by user271419 on 12/16/24.
//

import Foundation

struct SendOtpResponse: Codable {
    let success: Bool
    let message: String
}

struct LoginResponse: Codable {
    let success: Bool
    let message: String
    let token: String
}

struct ConversationMessageResponse: Codable {
    let success: Bool
    let conversations: [ConversationListItem]
}

struct ConversationWith: Codable {
    let id: String
    var name: String
    var recentMessageElipsizable: String
    var picUrl: String? = nil
}

struct ConversationListItem: Codable, Identifiable {
    let id: String
    let conversationWith: ConversationWith
    let data: [ChatMessage]
    var unreadCount = 0
}

//Usage: ChatMessage(id: "1", timestamp: Date().timeIntervalSince1970, userId: "1", textMsg: "Hello", mediaUrl: nil)
struct ChatMessage: Codable {
    let id : String
    let timestamp: Double
    let userId: String
    var textMsg: String? = nil // Markdown enabled text message
    var mediaUrl: String? = nil // Meida like image, pdf etc
}
