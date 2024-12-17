//
//  ChatsMainView.swift
//  Messenger
//
//  Created by Arnab Kar on 12/15/24.
//

import SwiftUI

struct ChatsMainView: View {
    
    @StateObject private var viewModel = ConversationViewModel()
    @StateObject var searchBarObservable = SearchObservable()
    @State private var searchResults: [ConversationListItem] = []
    
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
        .task {
            searchResults = viewModel.fetchConversations()
        }
    }
}

#Preview {
    ChatsMainView()
        .previewLayout(.sizeThatFits)
}
