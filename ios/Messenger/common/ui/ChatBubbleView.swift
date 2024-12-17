//
//  ChatBubbleView.swift
//  Messenger
//
//  Created by user271419 on 12/16/24.
//
import SwiftUI

struct ChatBubbleView: View {
    var message: String
    var isIncoming: Bool
    var backgroundColor: Color
    var textColor: Color
    
    var body: some View {
        HStack {
            if !isIncoming {
                Spacer() // pushes incoming bubble to the left
            }
            Text(message)
                .padding()
                .foregroundColor(textColor)
                .background(
                    ZStack {
                        backgroundColor
                            .cornerRadius(20)
                        if !isIncoming {
                            Triangle()
                                .fill(backgroundColor)
                                //.rotationEffect(.degrees(180))
                                .offset(x: 20, y: 0)
                        } else {
                            Triangle()
                                .fill(backgroundColor)
                                .offset(x: -20, y: 0)
                        }
                    }
                )
                .padding(isIncoming ? .leading : .trailing, 10)
            
            if isIncoming {
                Spacer() //pushes outgoing bubble to the right
            }
        }
        .padding(isIncoming ? .leading : .trailing, 15)
        .padding(.vertical, 5)
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.closeSubpath()
        }
    }
}

#Preview {
    VStack{
        ChatBubbleView(message: "Hello! How are you?", isIncoming: true, backgroundColor: .gray, textColor: .white)
        ChatBubbleView(message: "I am good", isIncoming: false, backgroundColor: .blue, textColor: .white)
    }
    .padding()
    .previewLayout(.sizeThatFits)

}
