//
//  ContentView.swift
//  HapticsExample
//
//  Created by Taewon Yoon on 4/12/24.
//

import SwiftUI

class HapticManager {
    static let instance = HapticManager() // 싱글톤
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20, content: {
            Button("error") { HapticManager.instance.notification(type: .error) }
            Button("success") { HapticManager.instance.notification(type: .success) }
            Button("warning") { HapticManager.instance.notification(type: .warning) }
            Divider()
            Button("soft") { HapticManager.instance.impact(style: .soft) }
            Button("heavy") { HapticManager.instance.impact(style: .heavy) }
            Button("medium") { HapticManager.instance.impact(style: .medium) }
            Button("rigid") { HapticManager.instance.impact(style: .rigid) }
            Button("light") { HapticManager.instance.impact(style: .light) }
        })
    }
}

#Preview {
    ContentView()
}
