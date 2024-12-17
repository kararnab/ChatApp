//
//  ContentView.swift
//  Messenger
//
//  Created by user271419 on 12/15/24.
//

import SwiftUI

struct EulaScreen: View {
    
    @EnvironmentObject var vm: UserStateViewModel
    
    let eulaText = """
    END USER LICENSE AGREEMENT (EULA)

    Please read this End User License Agreement carefully before using the app.
    
"""

    var body: some View {
        VStack {
            Text("End-User License Agreement")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)
                .foregroundColor(.primary)
            
            ScrollView {
                Text(eulaText)
                    .font(.body)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.primary)
            }
            .frame(maxHeight: .infinity)
            
            Spacer()
            
            HStack {
                ButtonView(
                    title: "Accept",
                    action: {
                        vm.acceptEULA()
                    },
                    backgroundColor: .green,
                    textColor: .white,
                    font: .headline,
                    cornerRadius: 10
                )
            }
            .padding(.bottom, 20)
        }
        .background(Color(UIColor.systemBackground))
        .navigationBarHidden(true)
        .padding()
    }
}

#Preview {
    EulaScreen()
        .environmentObject(UserStateViewModel())
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.dark)
}
