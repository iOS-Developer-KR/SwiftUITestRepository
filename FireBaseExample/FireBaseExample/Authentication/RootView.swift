//
//  RootView.swift
//  FireBaseExample
//
//  Created by Taewon Yoon on 4/12/24.
//

import SwiftUI

struct RootView: View {
    @State private var showSignView: Bool = false
    
    var body: some View {
        ZStack {
            NavigationStack {
                SettingsView(showSignInView: $showSignView)
            }
        }
        .onAppear {
            let authuser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignView = authuser == nil ? true : false
        }
        .fullScreenCover(isPresented: $showSignView, content: {
            NavigationStack {
                AuthenticationView(showSignInView: $showSignView)
            }
        })
    }
}

#Preview {
    RootView()
        .environment(SignInEmailViewModel())
}
