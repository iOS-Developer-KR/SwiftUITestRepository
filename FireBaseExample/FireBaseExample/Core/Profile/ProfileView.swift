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
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
    
    func addUserPreference(text: String) {
        guard let user else { return }
        
        Task {
            try await UserManager.shared.addUserPreference(userId: user.userId, preference: text)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
    
    func removeUserPreference(text: String) {
        guard let user else { return }
        
        Task {
            try await UserManager.shared.removeUserPreference(userId: user.userId, preference: text)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
    
    func addFavoriteMovie() {
        guard let user else { return }
        
        let movie = Movie(id: "1", title: "Avatar 2", isPopular: true)
        Task {
            try await UserManager.shared.addFavoriteMovie(userId: user.userId, movie: movie)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
    
    func removeFavoriteMovie() {
        guard let user else { return }
        
        Task {
            try await UserManager.shared.removeFavoriteMovie(userId: user.userId)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
}

struct ProfileView: View {
    
    @Environment(ProfileViewModel.self) var viewModel
    @Binding var showSignInView: Bool
    
    let preferenceOptions: [String] = ["Sports", "Movies", "Books"]

    @MainActor private func preferenceIsSelected(text: String) -> Bool {
        viewModel.user?.preferences?.contains(text) == true
    }
    
    var body: some View {
        List {
            if let user = viewModel.user {
                Text("UsreId: \(user.userId)")
                
                Button {
                    viewModel.togglePremiumStatus()
                } label: {
                    Text("User is premium: \((user.isPremium ?? false).description.capitalized)")
                }
                VStack {
                    HStack {
                        ForEach(preferenceOptions, id: \.self) { string in
                            Button(string) {
                                if preferenceIsSelected(text: string) {
                                    viewModel.removeUserPreference(text: string)
                                } else {
                                    viewModel.addUserPreference(text: string)
                                }
                            }
                            .buttonStyle(BorderedButtonStyle())
                            .tint(viewModel.user?.preferences?.contains(string) == true ? .green : .red)
                            .font(.headline)
                        }
                    }
                    Text("유저 선호: \((user.preferences ?? []).joined(separator: ", "))")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                Button {
                    if user.favoriteMovie == nil {
                        viewModel.addFavoriteMovie()
                    } else {
                        viewModel.removeFavoriteMovie()
                    }
                } label: {
                    Text("Favorite Movie: \((user.favoriteMovie?.title ?? ""))")
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
            .environment(SettingsViewModel())
            .environment(ProfileViewModel())
    }
}
