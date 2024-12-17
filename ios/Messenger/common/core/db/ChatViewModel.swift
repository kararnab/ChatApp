//
//  ChatViewModel.swift
//  Messenger
//
//  Created by Arnab Kar on 12/21/24.
//

import Foundation
import Combine

class ChatViewModel: ObservableObject {
    @Published var conversations: [(conversationId: Int, name: String, picUrl: String, unreadCount: Int)] = []
    private var databaseManager: DatabaseManager
    
    init(databaseManager: DatabaseManager = DatabaseManager()) {
        self.databaseManager = databaseManager
        self.fetchConversations()
    }
    
    func fetchConversations() {
        self.conversations = databaseManager.getConversations(limit: 20, offset: 0)
    }
}
