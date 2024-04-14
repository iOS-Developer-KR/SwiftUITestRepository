//
//  AuthenticationView.swift
//  FireBaseExample
//
//  Created by Taewon Yoon on 4/12/24.
//

import SwiftUI

struct AuthenticationView: View {
    @Environment(SignInEmailViewModel.self) var vm
    
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack {
            
            Button {
                Task {
                    do {
                        try await vm.signInAnonymous()
                        showSignInView = false
                    } catch {
                        print(error)
                    }
                }
            } label: {
                Text("익명으로 시작하기")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            NavigationLink {
                SignInEmailView(showSignInView: $showSignInView)
            } label: {
                Text("이메일로 회원가입하기")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            Spacer()
        }
        .navigationTitle("회원가입")
    }
}

#Preview {
    NavigationStack {
        AuthenticationView(showSignInView: .constant(false))
            .environment(SignInEmailViewModel())
            .environment(SettingsViewModel())
            .environment(ProfileViewModel())
    }
}
