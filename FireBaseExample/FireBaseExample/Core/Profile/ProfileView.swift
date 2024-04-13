//
//  ProfileView.swift
//  FireBaseExample
//
//  Created by Taewon Yoon on 4/13/24.
//

import SwiftUI

@MainActor
@Observable final class ProfileViewModel {
    
    private(set) var user: DBUser? = nil
    
    func loadCurrentuser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
    
    func togglePremiumStatus() {
        guard let user else { return }
        let currentValue = user.isPremium ?? false
        print(currentValue)
        Task {
            UserManager.shared.updateUserPremiumStatus(userId: user.userId, isPremium: !currentValue)
//            try UserManager.shared.updateUserPremiumStatus(user: user)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
}

struct ProfileView: View {
    
    @Environment(ProfileViewModel.self) var viewModel
    @Binding var showSignInView: Bool
    
    var body: some View {
        List {
            if let user = viewModel.user {
                Text("UsreId: \(user.userId)")
                
                Button {
                    viewModel.togglePremiumStatus()
                } label: {
                    Text("User is premium: \((user.isPremium ?? false).description.capitalized)")
                }
            }
        }
        .onAppear {
            Task {
                try? await viewModel.loadCurrentuser()
            }
        }
        .navigationTitle("유저 프로필")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    SettingsView(showSignInView: $showSignInView)
                } label: {
                    Image(systemName: "gear")
                        .font(.headline)
                }

                
            }
        }
    }
}

#Preview {
    NavigationStack {
        ProfileView(showSignInView: .constant(false))
            .environment(SignInEmailViewModel())
    }
}
