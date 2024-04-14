//
//  TabbarView.swift
//  FireBaseExample
//
//  Created by Taewon Yoon on 4/14/24.
//

import SwiftUI

struct TabbarView: View {
    
    @Binding var showSignInView: Bool
    
    var body: some View {
        TabView {
            NavigationStack {
                ProductsView()
            }
            .tabItem {
                Image(systemName: "cart")
                Text("Products")
            }
            
            NavigationStack {
                FavoriteView()
            }
            .tabItem {
                Image(systemName: "star.fill")
                Text("Favorites")
            }
            
            NavigationStack {
                ProfileView(showSignInView: $showSignInView)
            }
            .tabItem {
                Image(systemName: "person")
                Text("Profile") 
            }
        }
        
    }
}

#Preview {
    NavigationStack {
        TabbarView(showSignInView: .constant(false))
    }
}
