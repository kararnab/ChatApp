//
//  ChatViewModel.swift
//  Messenger
//
//  Created by Arnab Kar on 12/21/24.
//

import Foundation
import Combine

// Mocked Conversations
let mockConversations: [ConversationListItem] = [
    ConversationListItem(
        id: "2",
        conversationWith: ConversationWith(id: "2", name: "Rahul Kumar", recentMessageElipsizable: "Hello there"),
        data: [
            ChatMessage(id: 1, timestamp: Date().timeIntervalSince1970 + 3600, userId: 1, message: "Hello there!"),
            ChatMessage(id: 2, timestamp: Date().timeIntervalSince1970 + 3800, userId: 2, message: "Hi"),
            ChatMessage(id: 3, timestamp: Date().timeIntervalSince1970 + 4000, userId: 2, message: "How are you?"),
            ChatMessage(id: 4, timestamp: Date().timeIntervalSince1970 + 5000, userId: 1, message: "I am fine."),
        ]
    ),
    ConversationListItem(
        id: "3",
        conversationWith: ConversationWith(
            id: "3",
            name: "Amiya Sengupta",
            recentMessageElipsizable: "Hello there",
            picUrl: "https://static.vecteezy.com/system/resources/thumbnails/035/544/575/small_2x/ai-generated-cheerful-black-man-looking-at-camera-isolated-on-transparent-background-african-american-male-person-portrait-png.png"
        ),
        data: [
            ChatMessage(id: 5, timestamp: Date().timeIntervalSince1970, userId: 1, message: "Hey!"),
            ChatMessage(id: 6, timestamp: Date().timeIntervalSince1970 + 3600, userId: 3, message: "Hello, I am Three"),
            ChatMessage(id: 7, timestamp: Date().timeIntervalSince1970 + 4000, userId: 3, message: "How are you?"),
            ChatMessage(id: 8, timestamp: Date().timeIntervalSince1970 + 5000, userId: 1, message: "I am good."),
        ]
    ),
    ConversationListItem(
        id: "4",
        conversationWith: ConversationWith(
            id: "4",
            name: "Vincent John",
            recentMessageElipsizable: "Hello there, hope you are doing well. I am fine here. Ok, that should be a long message for a single line"
        ),
        data: [
            ChatMessage(id: 9, timestamp: epochFromCustomDate(dateString: "18 Oct 2006 10:30 AM") ?? -1, userId: 1, message: "Hey!"),
            ChatMessage(id: 10, timestamp: epochFromCustomDate(dateString: "20 Oct 2006 10:30 AM") ?? -1, userId: 4, message: "Hello, I am There"),
            ChatMessage(id: 11, timestamp: epochFromCustomDate(dateString: "23 Oct 2016 10:30 AM") ?? -1, userId: 4, message: "How are you?"),
            ChatMessage(id: 12, timestamp: epochFromCustomDate(dateString: "23 Oct 2016 10:31 AM") ?? -1, userId: 1, message: "I am good."),
        ]
    ),
    ConversationListItem(
        id: "5",
        conversationWith: ConversationWith(
            id: "5",
            name: "John McMilen",
            recentMessageElipsizable: "Hey John"
        ),
        data: [
            ChatMessage(id: 13, timestamp: epochFromCustomDate(dateString: "18 Oct 2006 10:30 AM") ?? -1, userId: 5, message: "Hey there!"),
            ChatMessage(id: 14, timestamp: epochFromCustomDate(dateString: "20 Oct 2006 10:31 AM") ?? -1, userId: 1, message: "Hello, I am There"),
            ChatMessage(id: 15, timestamp: epochFromCustomDate(dateString: "23 Oct 2016 10:32 AM") ?? -1, userId: 5, message: "How are you?"),
            ChatMessage(id: 16, timestamp: epochFromCustomDate(dateString: "23 Oct 2016 10:33 AM") ?? -1, userId: 1, message: "I am good."),
        ]
    ),
]

class ConversationViewModel: ObservableObject {
    
    private var databaseManager: DatabaseManager

    init(databaseManager: DatabaseManager = DatabaseManager()) {
        self.databaseManager = databaseManager
        //self.fetchConversations()
    }
    
    func importConversations() {
        databaseManager.insertConversations(conversations: mockConversations		)
    }
	
    // Fetch contacts from the database and update the contacts array
    func fetchConversations(limit: Int = 100, offset: Int = 0) -> [ConversationListItem] {
        return databaseManager.getConversations(limit: limit, offset: offset		)
    }
    
    func fetchChat(id: String, limit: Int = 200, offset: Int = 0) -> [ChatMessage] {
        return databaseManager.getMessagesForConversation(conversationId: id, limit: limit, offset: offset)
    }
}
