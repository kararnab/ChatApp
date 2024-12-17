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
               conversationId INTEGER PRIMARY KEY AUTOINCREMENT,
               name TEXT,
               picUrl TEXT,
               unreadCount INTEGER
           );
           """
       
       let createMessagesTable = """
           CREATE TABLE IF NOT EXISTS Messages (
               messageId INTEGER PRIMARY KEY AUTOINCREMENT,
               conversationId INTEGER,
               timestamp INTEGER,
               eventId TEXT,
               messageContent TEXT,
               FOREIGN KEY (conversationId) REFERENCES Conversations(conversationId)
           );
           """
       
       if sqlite3_exec(db, createConversationsTable, nil, nil, nil) != SQLITE_OK {
           print("Error creating Conversations table")
       }
       
       if sqlite3_exec(db, createMessagesTable, nil, nil, nil) != SQLITE_OK {
           print("Error creating Messages table")
       }
   }

   // Insert a new conversation
   func insertConversation(name: String, picUrl: String, unreadCount: Int) {
       let insertQuery = "INSERT INTO Conversations (name, picUrl, unreadCount) VALUES (?, ?, ?);"
       var stmt: OpaquePointer?
       if sqlite3_prepare_v2(db, insertQuery, -1, &stmt, nil) == SQLITE_OK {
           sqlite3_bind_text(stmt, 1, name, -1, nil)
           sqlite3_bind_text(stmt, 2, picUrl, -1, nil)
           sqlite3_bind_int(stmt, 3, Int32(unreadCount))
           
           if sqlite3_step(stmt) != SQLITE_DONE {
               print("Error inserting conversation")
           }
       }
       sqlite3_finalize(stmt)
   }
   
   // Insert multiple messages in a single transaction (bulk import)
   func insertMessages(messages: [(conversationId: Int, timestamp: Int, userId: String, eventId: String, messageContent: String)]) {
       let transactionStart = "BEGIN TRANSACTION;"
       let transactionEnd = "COMMIT;"
       
       var stmt: OpaquePointer?
       let insertQuery = "INSERT INTO Messages (conversationId, timestamp, userId, eventId, messageContent) VALUES (?, ?, ?, ?, ?);"
       
       // Begin transaction
       if sqlite3_exec(db, transactionStart, nil, nil, nil) != SQLITE_OK {
           print("Error starting transaction")
           return
       }
       
       // Prepare the insert statement
       if sqlite3_prepare_v2(db, insertQuery, -1, &stmt, nil) != SQLITE_OK {
           print("Error preparing insert statement")
           return
       }
       
       for message in messages {
           sqlite3_bind_int(stmt, 1, Int32(message.conversationId))
           sqlite3_bind_int(stmt, 2, Int32(message.timestamp))
           sqlite3_bind_text(stmt, 3, message.userId, -1, nil)
           sqlite3_bind_text(stmt, 4, message.eventId, -1, nil)
           sqlite3_bind_text(stmt, 5	, message.messageContent, -1, nil)
           
           if sqlite3_step(stmt) != SQLITE_DONE {
               print("Error inserting message with eventId: \(message.eventId)")
           }
           
           // Reset the statement to insert the next message
           sqlite3_reset(stmt)
       }
       
       // Commit transaction
       if sqlite3_exec(db, transactionEnd, nil, nil, nil) != SQLITE_OK {
           print("Error committing transaction")
       }
       
       sqlite3_finalize(stmt)
   }

   // Retrieve conversations (paginated by the most recent message)
   func getConversations(limit: Int, offset: Int) -> [(conversationId: Int, name: String, picUrl: String, unreadCount: Int)] {
       var conversations: [(Int, String, String, Int)] = []
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
               let conversationId = sqlite3_column_int(stmt, 0)
               let name = String(cString: sqlite3_column_text(stmt, 1))
               let picUrl = String(cString: sqlite3_column_text(stmt, 2))
               let unreadCount = sqlite3_column_int(stmt, 3)
               
               conversations.append((Int(conversationId), name, picUrl, Int(unreadCount)))
           }
       } else {
           print("Error retrieving conversations")
       }
       
       sqlite3_finalize(stmt)
       return conversations
   }
   
   // Retrieve messages for a specific conversation, paginated by recency
   func getMessagesForConversation(conversationId: Int, limit: Int, offset: Int) -> [(messageId: Int, timestamp: Int, eventId: String, messageContent: String)] {
       var messages: [(Int, Int, String, String)] = []
       let query = """
           SELECT messageId, timestamp, userId, eventId, messageContent
           FROM Messages
           WHERE conversationId = ?
           ORDER BY timestamp DESC
           LIMIT ? OFFSET ?;
           """
       
       var stmt: OpaquePointer?
       if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
           sqlite3_bind_int(stmt, 1, Int32(conversationId))
           sqlite3_bind_int(stmt, 2, Int32(limit))
           sqlite3_bind_int(stmt, 3, Int32(offset))
           
           while sqlite3_step(stmt) == SQLITE_ROW {
               let messageId = sqlite3_column_int(stmt, 0)
               let timestamp = sqlite3_column_int(stmt, 1)
               let eventId = String(cString: sqlite3_column_text(stmt, 2))
               let messageContent = String(cString: sqlite3_column_text(stmt, 3))
               
               messages.append((Int(messageId), Int(timestamp), eventId, messageContent))
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
