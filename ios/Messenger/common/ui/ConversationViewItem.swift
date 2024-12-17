//
//  ConversationViewItem.swift
//  Messenger
//
//  Created by Arnab Kar on 12/17/24.
//

import SwiftUI

struct ConversationViewItem: View {
    let conversation: ConversationListItem
    
    var body: some View {
        HStack(alignment: .center) {
            Text(Image(systemName: "person")).frame(width: 50, height: 50)
                .cornerRadius(25)
            VStack(alignment: .leading){
                Text(conversation.conversationWith.name)
                    .font(.headline)
                    .lineLimit(1)
                Text(conversation.conversationWith.recentMessageElipsizable)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            .padding(.leading, 10)
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("Yesterday") //TODO:
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                if conversation.unreadCount != "0" {
                    Text("\(conversation.unreadCount)")
                        .font(.callout)
                        .foregroundColor(.white)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }
            }
            .padding(.trailing, 10)
        }
    }
}

#Preview {
    let conversation = mockConversations[0]

    ConversationViewItem(conversation: conversation)
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.light)
}
