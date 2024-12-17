//
//  TextFieldView.swift
//  Messenger
//
//  Created by Arnab Kar on 12/16/24.
//
import SwiftUI

struct TextFieldView: View {
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .background(Color(UIColor.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal)
    }
}

#Preview {
    TextFieldView(placeholder: "Enter Phone number", text: .constant(""))
        .previewLayout(.sizeThatFits)
        .padding()
        .background(Color.white)
}
