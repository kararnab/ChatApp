//
//  ChatDetailsScreen.swift
//  Messenger
//
//  Created by Arnab Kar on 12/17/24.
//

import SwiftUI

let mockedConversation = ConversationListItem(id: "2", conversationWith: ConversationWith(id: "2", name: "Rahul Kumar", recentMessageElipsizable: "Hello there"), data: [
    ChatMessage(id: "1", timestamp: Date().timeIntervalSince1970, userId: "1", textMsg: "Hello there", mediaUrl: nil),
    ChatMessage(id: "2", timestamp: Date().timeIntervalSince1970, userId: "2", textMsg: "Hi", mediaUrl: nil),
    ChatMessage(id: "3", timestamp: Date().timeIntervalSince1970, userId: "2", textMsg: "How are you", mediaUrl: nil),
    ChatMessage(id: "4", timestamp: Date().timeIntervalSince1970, userId: "1", textMsg: "Hi", mediaUrl: nil),
])

struct ChatDetailsScreen: View {
    var id: String
    
    @State private var messages: [Message] = [
        Message(text: "Hi", isIncoming: true),
        Message(text: "Hello, how are you", isIncoming: false),
        Message(text: "I'm good, thanks for asking", isIncoming: true),
        Message(text: "How about you", isIncoming: true),
        Message(text: "Hi", isIncoming: true),
        Message(text: "I am doing great, have you seen the new movie in the town", isIncoming: false),
        Message(text: "No", isIncoming: true),
        Message(text: "How's it?", isIncoming: true),
        Message(text: "it's great", isIncoming: false),
        Message(text: "You should watch it atleast once", isIncoming: false),
        Message(text: "Okay", isIncoming: true),
    ]
    
    @State private var newMessage = ""
    @State private var isInitialized = true
    
    var body: some View {
        VStack {
            ScrollViewReader { scrollViewProxy in
                List {
                    ForEach(messages) { message in
                        ChatBubbleView(
                            message: message.text, isIncoming: message.isIncoming, backgroundColor: message.isIncoming ? Color.gray : Color.blue, textColor: Color.white
                        )
                        .id(message.id)
                    }
                }
                .listStyle(PlainListStyle())
                .onChange(of: messages.count) { _ in
                    scrollToBottom(s: scrollViewProxy, animated: true)
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        scrollToBottom(s: scrollViewProxy, animated: false)
                    }
                }
            }
            HStack {
                TextField("Type a message", text: $newMessage)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(20)
                    .padding(.horizontal)
                
                Button(action: {
                    sendMessage()
                }){
                    Text("Send")
                        .font(.system(size: 16, weight: .semibold))
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
                .padding(.trailing)
            }
            .padding(.bottom)
        }
    }
    
    func sendMessage() {
        guard !newMessage.isEmpty else { return }
        
        messages.append(Message(text: newMessage, isIncoming: false))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            messages.append(Message(text: "Got your message", isIncoming: true))
        }
        
        newMessage = ""
    }
    
    func scrollToBottom(s scrollViewProxy: ScrollViewProxy) {
        if let lastMessage = messages.last {
            withAnimation{
                scrollViewProxy.scrollTo(lastMessage.id, anchor: .bottom)
            }
        }
        scrollToBottom(s: scrollViewProxy, animated: true)
    }
    
    func scrollToBottom(s scrollViewProxy: ScrollViewProxy, animated: Bool) {
        if let lastMessage = messages.last {
            withAnimation(animated ? .easeOut : nil) {
                scrollViewProxy.scrollTo(lastMessage.id, anchor: .bottom)
            }
        }
    }
}

struct Message: Identifiable {
    var id = UUID()
    var text: String
    var isIncoming: Bool
}
