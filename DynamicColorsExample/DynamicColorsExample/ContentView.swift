//
//  ContentView.swift
//  DynamicColorsExample
//
//  Created by Taewon Yoon on 4/21/24.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    @Environment(\.colorSchemeContrast) var colorSchemeContrast
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    var body: some View {
        NavigationStack {
            VStack {
                
                Button("Button 1") {
                    
                }
                .foregroundStyle(colorSchemeContrast == .increased ? .white : .primary)
                .buttonStyle(BorderedButtonStyle())
                
                Button("Button 2") {
                    
                }
                .foregroundStyle(.primary)
                .buttonStyle(BorderedButtonStyle())
                .tint(.orange)
                
                Button("Button 3") {
                    
                }
                .foregroundStyle(.primary)
                .buttonStyle(BorderedButtonStyle())
                .tint(.green)
                
                Button("Button 4") {
                    
                }
                .foregroundStyle(.primary)
                .buttonStyle(BorderedButtonStyle())
                .tint(accessibilityDifferentiateWithoutColor ? .black : .purple)
                
            }
            .font(.largeTitle)
//            .navigationTitle("Hi")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(reduceTransparency ? Color.black : Color.black.opacity(0.5))
        }
    }
}

#Preview {
    ContentView()
}
