//
//  NetworkResponse.swift
//  Messenger
//
//  Created by Arnab Kar on 12/16/24.
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
    var picUrl: String = "www.xyz.com"
}

struct ConversationListItem: Codable, Identifiable {
    let id: String
    let conversationWith: ConversationWith
    let data: [ChatMessage]
    var unreadCount = "0"
}

// Usage: ChatMessage(id: 1, timestamp: Date().timeIntervalSince1970, userId: "1", message: "Hello")
struct ChatMessage: Codable {
    let id : Int32
    let timestamp: Double
    var eventId: Int32 = 0
    var userId: Int32 = 0
    var message: String? = nil // Markdown enabled text message
}
