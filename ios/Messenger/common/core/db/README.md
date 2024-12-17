## Database Schema
---
1. Conversations Table
    - conversationId (INTEGER PRIMARY KEY)
    - name (TEXT)
    - picUrl (TEXT)
    - unreadCount (INTEGER)

2. Messages Table
    - messageId (INTEGER PRIMARY KEY)
    - conversationId(INTEGER) REFERENCES Conversations(conversationId)
    - timestamp (INTEGER) - Unix timestamp for sorting
    - eventId (TEXT) - Unique identifier for each message
    - messageContent (TEXT)
