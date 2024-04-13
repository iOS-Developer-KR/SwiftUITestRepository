//
//  SignInEmailViewModel.swift
//  FireBaseExample
//
//  Created by Taewon Yoon on 4/13/24.
//

import Foundation

@MainActor
@Observable final class SignInEmailViewModel: ObservableObject {
    
    var email = ""
    var password = ""
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        
        let returnedUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
        
    }
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        
        let returnedUserData = try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }
}
