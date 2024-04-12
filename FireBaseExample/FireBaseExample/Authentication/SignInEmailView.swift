//
//  SignInEmailView.swift
//  FireBaseExample
//
//  Created by Taewon Yoon on 4/12/24.
//

import SwiftUI

@MainActor
@Observable final class SignInEmailViewModel: ObservableObject {
    
    var email = ""
    var password = ""
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        
        let returnedUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
        
    }
}

struct SignInEmailView: View {
    
    @Environment(SignInEmailViewModel.self) var vm
    @Binding var showSignInView: Bool
    
    var body: some View {
        @Bindable var vm = vm
        VStack {
            TextField("이메일...", text: $vm.email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            SecureField("비밀번호...", text: $vm.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Button(action: {
                Task {
                    do {
                        try await vm.signIn()
                    } catch {
                        print("error:\(error)")
                    }
                }
            }, label: {
                Text("회원가입")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            })
            
            Spacer()
        }
        .navigationTitle("이메일로 회원가입")
    }
}

#Preview {
    SignInEmailView(showSignInView: .constant(false))
}
