//
//  ChatDetailsScreen.swift
//  Messenger
//
//  Created by Arnab Kar on 12/17/24.
//

import SwiftUI

struct ChatDetailsScreen: View {
    var id: String
    
    @StateObject private var viewModel = ConversationViewModel()
    
    @State private var messages: [Message] = []
    @State private var newMessage = ""
    @State private var isInitialized = true // Track if it's the first load
    @State private var messageId: Double = 0;
    
    var body: some View {
        VStack {
            ScrollViewReader { scrollViewProxy in
                List {
                    ForEach(messages) { message in
                        ChatBubbleView(
                            message: message.text, isIncoming: message.isIncoming, backgroundColor: message.isIncoming ? Color.gray : Color.blue, textColor: Color.white
                        )
                        .id(message.id) //Add unique id for scrolling
                        .listRowSeparator(.hidden)
                    }
                    .listRowInsets(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
                }
                .listStyle(PlainListStyle())    // Removes default list styling
                .onChange(of: messages.count) { _ in
                    // Scroll to botom whenever the number of messages changes
                    scrollToBottom(s: scrollViewProxy, animated: true)
                }
                .onAppear {
                    //Delay the scroll to ensure the list is rendered
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        scrollToBottom(s: scrollViewProxy, animated: false)
                    }
                }
                .task {
                    viewModel.fetchChat(id: id).forEach { chat in
                        var isIncoming = false
                        if (id == "\(chat.userId)") {
                            isIncoming = true
                        }
                        messageId += 1
                        messages.append(Message(id: messageId, text: chat.message ?? "", isIncoming: isIncoming))
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
        
        messageId += 1
        messages.append(Message(id: messageId, text: newMessage, isIncoming: false))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            messages.append(Message(id: messageId, text: "Got your message", isIncoming: true))
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
    var id: Double
    var text: String
    var isIncoming: Bool
}
