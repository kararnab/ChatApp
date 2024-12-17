//
//  ContentView.swift
//  Messenger
//
//  Created by user271419 on 12/15/24.
//

import SwiftUI

struct HomeScreen: View {
    
    @EnvironmentObject var vm: UserStateViewModel
    
    @State private var selectedTab = 0
    
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ChatsMainView()
                .tabItem{
                    Image(systemName: "text.bubble")
                    Text("Chats")
                }
                .tag(0)
            StatusView()
                .tabItem{
                    Image(systemName: "circle")
                    Text("Status")
                }
                .tag(1)
            CallsView()
                .tabItem{
                    Image(systemName: "phone")
                    Text("Calls")
                }
                .tag(2)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Text("WhatsApp")
                    .font(.title)
                    .foregroundColor(.blue)
                    .fontWeight(.semibold)
                    .padding(.horizontal)
            }
            ToolbarItem(placement: .navigationBarTrailing){
                Button(action: {
                    
                }) {
                    Image(systemName: "camera")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing){
                Menu {
                    Button("Settings"){
                        //Handle settings action
                    }
                    Button("Logout"){
                        Task {
                            await vm.signOut()
                        }
                    }
                } label: {
                    Image(systemName: "ellipsis")
                }
            }
        }
    }
}

struct StatusView: View {
    var body: some View {
        Text("Status View")
    }
}

struct CallsView: View {
    var body: some View {
        Text("Calls View")
    }
}

#Preview {
    HomeScreen()
        .environmentObject(UserStateViewModel())
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.dark)
}
