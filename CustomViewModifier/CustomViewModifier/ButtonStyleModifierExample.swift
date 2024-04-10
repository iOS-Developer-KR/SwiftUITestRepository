//
//  ButtonStyleModifier.swift
//  CustomViewModifier
//
//  Created by Taewon Yoon on 4/7/24.
//

import SwiftUI

struct PressableStyle: ButtonStyle {
    
    let scaledAmount: CGFloat
    
    init(scaledAmount: CGFloat = 0.9) {
        self.scaledAmount = scaledAmount
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundStyle(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0.0, y: 10.0)
            //.opacity(configuration.isPressed ? 0.9 : 1.0)
            .brightness(configuration.isPressed ? 0.05 : 0)
            .scaleEffect(configuration.isPressed ? scaledAmount : 1.0)
    }
}

extension View {
    func withPressableStyle(scaledAmout: CGFloat = 0.9) -> some View {
        self.buttonStyle(PressableStyle())
    }
}

struct ButtonStyleModifierExample: View {
    var body: some View {
        Button(action: {
            
        }, label: {
            Text("Button")
        })
        .withPressableStyle()
//        .buttonStyle(PressableStyle(scaledAmount: 0.5))
        .padding(40)
    }
}

#Preview {
    ButtonStyleModifierExample()
}
