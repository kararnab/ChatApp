//
//  DatabaseManager.swift
//  Messenger
//
//  Created by Arnab Kar on 12/21/24.
//

import SQLite3
import Foundation

class DatabaseManager {
    var db: OpaquePointer?

    init() {
        self.db = openDatabase()
        createTables()  // Ensure the table is created when the database is opened
    }

    // Open the SQLite database
    private func openDatabase() -> OpaquePointer? {
        var db: OpaquePointer? = nil
        let filePath = getDatabaseFilePath()

        if sqlite3_open(filePath, &db) != SQLITE_OK {
            print("Error opening database")
            return nil
        }
        return db
    }

    // Get the file path for the SQLite database
    private func getDatabaseFilePath() -> String {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let dbPath = documentsDirectory.appendingPathComponent("chatDatabase.sqlite")
        return dbPath.path
    }

    // Create the contacts table if it doesn't exist
    private func createTables() {
        let createConversationsTable = """
            CREATE TABLE IF NOT EXISTS Conversations (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                conversationId TEXT UNIQUE,
                name TEXT,
                picUrl TEXT,
                unreadCount TEXT
            );
            """
        
        let createMessagesTable = """
            CREATE TABLE IF NOT EXISTS Messages (
                messageId INTEGER PRIMARY KEY AUTOINCREMENT,
                conversationId TEXT,
                timestamp INTEGER,
                userId INTEGER,
                eventId INTEGER,
                messageContent TEXT,
                FOREIGN KEY (conversationId) REFERENCES Conversations(conversationId)
            );
            """
        
        if sqlite3_exec(db, createConversationsTable, nil, nil, nil) != SQLITE_OK {
            print("Error creating Conversations table")
        } else {
            print("Conversations table created")
        }
        
        if sqlite3_exec(db, createMessagesTable, nil, nil, nil) != SQLITE_OK {
            print("Error creating Messages table")
        } else {
            print("Messages table created")
        }
    }
    
    //Bulk Insert
    func insertConversations(conversations: [ConversationListItem]) {
        print("\nInserting conversation list items and their messages in bulk")
        
        // SQL Queries
        let insertConversationQuery = """
            INSERT INTO Conversations (conversationId, name, picUrl, unreadCount)
            VALUES (?, ?, ?, ?);
        """
        
        let insertMessageQuery = """
            INSERT INTO Messages (conversationId, timestamp, userId, eventId, messageContent)
            VALUES (?, ?, ?, ?, ?);
        """
        
        // Start Transaction
        let transactionStart = "BEGIN TRANSACTION;"
        let transactionEnd = "COMMIT;"
        
        // Begin Transaction
        guard executeQuery(transactionStart) else {
            print("Error starting transaction.")
            return
        }
        
        // Prepare statements
        var conversationStmt: OpaquePointer?
        var messageStmt: OpaquePointer?
        
        if sqlite3_prepare_v2(db, insertConversationQuery, -1, &conversationStmt, nil) != SQLITE_OK {
            print("Error preparing conversation insert statement: \(String(cString: sqlite3_errmsg(db)))")
            return
        }
        
        if sqlite3_prepare_v2(db, insertMessageQuery, -1, &messageStmt, nil) != SQLITE_OK {
            print("Error preparing message insert statement: \(String(cString: sqlite3_errmsg(db)))")
            sqlite3_finalize(conversationStmt)
            return
        }
        
        // Insert Conversations
        for conversation in conversations {
            bindConversationParams(conversationStmt, conversation)
            if !executeStatement(conversationStmt) {
                print("Error inserting conversation with ID \(conversation.conversationWith.id)")
            }
            sqlite3_reset(conversationStmt)
        }
        
        // Insert Messages
        for conversation in conversations {
            for message in conversation.data {
                bindMessageParams(messageStmt, conversation, message)
                if !executeStatement(messageStmt) {
                    print("Error inserting message with ID \(message.id)")
                }
                sqlite3_reset(messageStmt)
            }
        }
        
        // Finalize Statements
        sqlite3_finalize(conversationStmt)
        sqlite3_finalize(messageStmt)
        
        // Commit Transaction
        guard executeQuery(transactionEnd) else {
            print("Error committing transaction.")
            return
        }
        
        print("Bulk insert of conversations and messages completed successfully.")
    }
    
    //Helpers
    func executeQuery(_ query: String) -> Bool {
        if sqlite3_exec(db, query, nil, nil, nil) != SQLITE_OK {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("Error executing query: \(errorMessage)")
            return false
        }
        return true
    }
    func bindConversationParams(_ statement: OpaquePointer?, _ conversation: ConversationListItem) {
        let conversationId = (conversation.conversationWith.id as NSString).utf8String
        let name = (conversation.conversationWith.name as NSString).utf8String
        let picUrl = (conversation.conversationWith.picUrl as NSString).utf8String
        let unreadCount = (conversation.unreadCount as NSString).utf8String
        
        sqlite3_bind_text(statement, 1, conversationId, -1, nil)
        sqlite3_bind_text(statement, 2, name, -1, nil)
        sqlite3_bind_text(statement, 3, picUrl, -1, nil)
        sqlite3_bind_text(statement, 4, unreadCount, -1, nil)
        
        print("Binding conversation: \(String(describing: conversationId)), \(String(describing: name)), \(String(describing: picUrl)), \(String(describing: unreadCount))")
    }
    func bindMessageParams(_ statement: OpaquePointer?, _ conversation: ConversationListItem, _ message: ChatMessage) {
        let conversationId = (conversation.conversationWith.id as NSString).utf8String
        let messageContent = ((message.message ?? "") as NSString).utf8String
        
        sqlite3_bind_text(statement, 1, conversationId, -1, nil)
        sqlite3_bind_double(statement, 2, message.timestamp)
        sqlite3_bind_int(statement, 3, message.userId)
        sqlite3_bind_int(statement, 4, message.eventId)
        sqlite3_bind_text(statement, 5, messageContent, -1, nil)
    }
    func executeStatement(_ statement: OpaquePointer?) -> Bool {
        if sqlite3_step(statement) != SQLITE_DONE {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("Error executing statement: \(errorMessage)")
            return false
        }
        return true
    }

    // Retrieve conversations (paginated by the most recent message)
    func getConversations(limit: Int, offset: Int) -> [ConversationListItem] {
        var conversations: [ConversationListItem] = []
        let query = """
            SELECT c.conversationId, c.name, c.picUrl, c.unreadCount
            FROM Conversations c
            LEFT JOIN Messages m ON c.conversationId = m.conversationId
            GROUP BY c.conversationId
            ORDER BY MAX(m.timestamp) DESC
            LIMIT ? OFFSET ?;
            """
        
        var stmt: OpaquePointer?
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
            sqlite3_bind_int(stmt, 1, Int32(limit))
            sqlite3_bind_int(stmt, 2, Int32(offset))
            
            while sqlite3_step(stmt) == SQLITE_ROW {
                let conversationId = String(cString: sqlite3_column_text(stmt, 0))
                let name = String(cString: sqlite3_column_text(stmt, 1))
                let picUrl = String(cString: sqlite3_column_text(stmt, 2))
                let unreadCount = String(cString: sqlite3_column_text(stmt, 3))
                
                conversations.append(ConversationListItem(id: conversationId, conversationWith: ConversationWith(id: conversationId, name: name, recentMessageElipsizable: "Hello User", picUrl: picUrl), data: [], unreadCount: unreadCount))
            }
        } else {
            print("Error retrieving conversations")
        }
        
        sqlite3_finalize(stmt)
        return conversations
    }
    
    // Retrieve messages for a specific conversation, paginated by recency
    func getMessagesForConversation(conversationId: String, limit: Int, offset: Int) -> [ChatMessage] {
        var messages: [ChatMessage] = []
        let query = """
            SELECT messageId, timestamp, eventId, userId, messageContent
            FROM Messages
            WHERE conversationId = ?
            ORDER BY timestamp DESC
            LIMIT ? OFFSET ?;
            """
        
        var stmt: OpaquePointer?
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
            sqlite3_bind_text(stmt, 1, (conversationId as NSString).utf8String, -1, nil)
            sqlite3_bind_int(stmt, 2, Int32(limit))
            sqlite3_bind_int(stmt, 3, Int32(offset))
            
            while sqlite3_step(stmt) == SQLITE_ROW {
                let messageId = sqlite3_column_int(stmt, 0)
                let timestamp = sqlite3_column_int(stmt, 1)
                let eventId = sqlite3_column_int(stmt, 2)
                let userId = sqlite3_column_int(stmt, 3)
                let messageContent = String(cString: sqlite3_column_text(stmt, 4))
                
                messages.append(ChatMessage(id: messageId, timestamp: Double(timestamp), eventId: eventId, userId: userId, message: messageContent))
            }
        } else {
            print("Error retrieving messages")
        }
        
        sqlite3_finalize(stmt)
        return messages
    }

    // Close the database connection
    func closeDatabase() {
        sqlite3_close(db)
    }
}
