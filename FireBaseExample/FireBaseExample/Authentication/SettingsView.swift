//
//  SettingsView.swift
//  FireBaseExample
//
//  Created by Taewon Yoon on 4/12/24.
//

import SwiftUI

@MainActor
@Observable final class SettingsViewModel {
    
    func logOut() throws {
        try AuthenticationManager.shared.signOut()
    }
}

struct SettingsView: View {
    
    @Environment(SettingsViewModel.self) var vm
    @Binding var showSignInView: Bool
    
    var body: some View {
        List {
            Button("로그아웃") {
                Task {
                    do {
                        try vm.logOut()
                        showSignInView = true
                    } catch {
                        print("error:\(error)")
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView(showSignInView: .constant(false))
    }
}
