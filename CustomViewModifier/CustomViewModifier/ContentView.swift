//
//  ContentView.swift
//  CustomViewModifier
//
//  Created by Taewon Yoon on 4/7/24.
//

import SwiftUI

struct DefaultButtonModifier: ViewModifier {
    
    let backgroundColor: Color
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundStyle(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .padding()
    }
}

extension View {
    func withDefaultButtonFormatting(backgroundColor: Color = .blue) -> some View {
        modifier(DefaultButtonModifier(backgroundColor: backgroundColor))
    }
}

struct ContentView: View {
    
    var body: some View {
        Text("Hello, world")
            .withDefaultButtonFormatting()
//            .modifier(DefaultButtonModifier())
        
        Text("Hello, everyone")
            .withDefaultButtonFormatting(backgroundColor: .orange)
//            .modifier(DefaultButtonModifier())

        Text("Hello, anyone")
            .withDefaultButtonFormatting(backgroundColor: .pink)
//            .modifier(DefaultButtonModifier())
    }
    
}

#Preview {
    ContentView()
}
