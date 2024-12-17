//
//  ButtonView.swift
//  Messenger
//
//  Created by Arnab Kar on 12/16/24.
//

import SwiftUI

struct ButtonView: View {
    var title: String
    var disabled: Bool = false
    var action: () -> Void

    var backgroundColor: Color = Color.blue
    var textColor: Color = .white
    var font: Font = .headline
    var cornerRadius: CGFloat = 10
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(font)
                .fontWeight(.bold)
                .foregroundColor(textColor)
                .frame(maxWidth: .infinity)
                .padding()
                .background(disabled ? Color.gray : backgroundColor)
                .cornerRadius(cornerRadius)
        }
        .padding(.horizontal)
        .disabled(disabled)
    }
}

#Preview {
    ButtonView(title: "Register", action: {
        // Action for the button
    })
    .previewLayout(.sizeThatFits)
    .padding()
}
