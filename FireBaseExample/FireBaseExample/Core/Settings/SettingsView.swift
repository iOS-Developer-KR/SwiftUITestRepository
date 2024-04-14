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
    
    func resetPassword() async throws {
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        
        guard let email = authUser.email else {
            throw URLError(.networkConnectionLost)
        }
        try await AuthenticationManager.shared.resetPassword(email: email)
    }
    
    func updateEmail(email: String) async throws {
        try await AuthenticationManager.shared.updateEmail(email: email)
    }
    
    func updatePassword(password: String) async throws {
        try await AuthenticationManager.shared.updatePassword(password: password)
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
            
            emailSection

            

        }
    }
}

#Preview {
    NavigationStack {
        SettingsView(showSignInView: .constant(false))
            .environment(SignInEmailViewModel())
            .environment(SettingsViewModel())
            .environment(ProfileViewModel())
    }
}

extension SettingsView {
    
    private var emailSection: some View {
        Section {
            Button("비밀번호 초기화") {
                Task {
                    do {
                        try await vm.resetPassword()
                    } catch {
                        print("error:\(error)")
                    }
                }
            }
            
            Button("비밀번호 수정") {
                Task {
                    do {
                        try await vm.updatePassword(password: "111111")
                        print("비밀번호 수정")
                    } catch {
                        print("error:\(error)")
                    }
                }
            }
            
            Button("이메일 수정") {
                print("수정")
                Task {
                    do {
                        try await vm.updateEmail(email: "happyytw@gmail.com")
                    } catch {
                        print("error:\(error)")
                    }
                }
            }
        } header: {
            Text("회원정보 수정")
        }
    }
}
