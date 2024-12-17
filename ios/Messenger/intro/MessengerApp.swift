//
//  MessengerApp.swift
//  Messenger
//
//  Created by user271419 on 12/15/24.
//

import SwiftUI

@main
struct MessengerApp: App {
    
    @StateObject var userStateViewModel = UserStateViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ApplicationSwitcher()
            }
            .navigationViewStyle(.stack)
            .environmentObject(userStateViewModel)
        }
    }
}

struct ApplicationSwitcher: View {
    
    @EnvironmentObject var vm: UserStateViewModel
    
    var body: some View {
        Group {
            if(!vm.hasAcceptedEULA) {
                EulaScreen()
            } else if (!vm.isLoggedIn) {
                PhoneVerificationView()
            } else {
                HomeScreen()
            }
        }
        .transition(.slide)
        .animation(.easeOut(duration: 0.3), value: vm.isLoggedIn)
    }
}
