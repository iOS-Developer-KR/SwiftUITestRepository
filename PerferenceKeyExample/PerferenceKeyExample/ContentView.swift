//
//  ContentView.swift
//  PerferenceKeyExample
//
//  Created by Taewon Yoon on 4/19/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var text = "abc"
    
    var body: some View {
        
        NavigationStack {
            VStack {
                SecondaryScreen(text: text)
                    .navigationTitle("네비게이션 타이틀")
                    .preference(key: CustomTitlePreferenceKey.self, value: "NEW VALUE")
            }
        }
        .onPreferenceChange(CustomTitlePreferenceKey.self, perform: { value in
            self.text = value
        })
    }
}

extension View {
    
    func customTitle(text: String) -> some View {
        preference(key: CustomTitlePreferenceKey.self, value: text)
    }
}

#Preview {
    ContentView()
}

struct SecondaryScreen: View {
    
    let text: String
    @State private var newValue: String = ""
    
    var body: some View {
        Text(text)
            .onAppear { getData() }
            .customTitle(text: newValue)
    }
    
    func getData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.newValue = "New value downloaded"
        }
    }
}

struct CustomTitlePreferenceKey: PreferenceKey {
    
    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}
