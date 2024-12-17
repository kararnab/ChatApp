//
//  ChatsMainView.swift
//  Messenger
//
//  Created by user271419 on 12/15/24.
//

import SwiftUI

//Mocked
let conversation2 = ConversationListItem(id: "2", conversationWith: ConversationWith(id: "1", name: "Rahul kumar", recentMessageElipsizable: "Hello there"), data: [
    ChatMessage(id: "1", timestamp: Date().timeIntervalSince1970, userId: "1", textMsg: "Hello there", mediaUrl: nil),
    ChatMessage(id: "2", timestamp: Date().timeIntervalSince1970, userId: "2", textMsg: "Hi", mediaUrl: nil),
])

let conversation3 = ConversationListItem(id: "3", conversationWith: ConversationWith(id: "1", name: "Ronit kumar", recentMessageElipsizable: "Hello "), data: [
    ChatMessage(id: "1", timestamp: Date().timeIntervalSince1970, userId: "1", textMsg: "Hello", mediaUrl: nil),
    ChatMessage(id: "2", timestamp: Date().timeIntervalSince1970, userId: "3", textMsg: "Hi", mediaUrl: nil),
])

struct ChatsMainView: View {
    
    @StateObject var searchBarObservable = SearchObservable()
    @State private var searchResults: [ConversationListItem] = [
        conversation2,
        conversation3
    ]
    
    var filteredResults: [ConversationListItem] {
        searchBarObservable.searchedText.isEmpty ? searchResults :
        searchResults.filter {
            $0.conversationWith.name.lowercased().contains(searchBarObservable.searchedText.lowercased())
        }
    }
    
    var body: some View {
        VStack {
            SearchBarView(searchObservable: searchBarObservable)
        
            List {
                ForEach(filteredResults) { result in
                    NavigationLink(destination: ChatDetailsScreen(id: result.id)) {
                        ConversationViewItem(conversation: result)
                    }
                    .listRowSeparator(.hidden)
                }
                .listRowInsets(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
            }
            .animation(.spring)
            .buttonStyle(.bordered)
            .listStyle(.plain)
        }
        .padding()
    }
}

#Preview {
    ChatsMainView()
        .previewLayout(.sizeThatFits)
}
