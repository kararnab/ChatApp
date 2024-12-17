# iOS App

## Description
---
Similar to the Android app, this is a webchat messenger implementation in iOS

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


## Questions:
- Difference between @EnvironmentObject, @StateObject and @State
- What is @MainActor and @Published
- NavigationStack (or depricated NavigationView) and NavigationLink
- guard and self
- [NavigatioinLink](https://stackoverflow.com/questions/57130866/how-to-show-navigationlink-as-a-button-in-swiftui)
- [Swift Pointer Troubleshooting](https://stackoverflow.com/questions/28142226/sqlite-for-swift-is-unstable)
- [Task vs OnAppear](https://stackoverflow.com/questions/68114509/what-is-the-difference-between-onappear-and-task-in-swiftui-3)
