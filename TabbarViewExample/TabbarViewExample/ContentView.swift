//
//  ContentView.swift
//  TabbarViewExample
//
//  Created by Taewon Yoon on 4/22/24.
//

import SwiftUI

// Generics
// ViewBuilder
// PreferenceKey
// MatchedGeometryEffect

struct ContentView: View {
    
    @State private var selection: String = "home"
    @State private var tabSelection: TabBarItem = .home
    var body: some View {
        CustomTabBarContainerView(selection: $tabSelection) {
            // 4개의 뷰를 포함하는 ContainerView
            // .tabBarItem은 각 뷰의 커스텀 modifier로 선택된 화면만 보여주도록 만든다
            Color.blue
                .tabBarItem(tab: .home, selection: $tabSelection)
            
            Color.red
                .tabBarItem(tab: .favorite, selection: $tabSelection)
            
            Color.green
                .tabBarItem(tab: .profile, selection: $tabSelection)
            
            Color.orange
                .tabBarItem(tab: .message, selection: $tabSelection)
        }
    }
}

#Preview {
    ContentView()
}

extension ContentView {
    
    private var defaultTabView: some View {
        TabView(selection: $selection,
                content:  {
            Color.red
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            Color.blue
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorite")
                }
            
            Color.orange
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        })
    }
}
