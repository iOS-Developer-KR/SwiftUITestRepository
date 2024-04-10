//
//  ContentView.swift
//  FocusStateExample
//
//  Created by Taewon Yoon on 4/6/24.
//

import SwiftUI

struct ContentView: View {
    
    enum OnboardingFields: Hashable {
        case username
        case password
    }
    
//    @FocusState private var usernameInFocus: Bool
    @State private var username: String = ""
//    @FocusState private var passwordInFocus: Bool
    @State private var password: String = ""
    @State private var buttonText: String = "SIGN UP 🚀"
    @FocusState private var fieldInFocus: OnboardingFields?
    var body: some View {
        VStack {
            TextField("Add your name here...", text: $username)
                .focused($fieldInFocus, equals: .username)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.gray.brightness(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            SecureField("Add your password here...", text: $password)
                .focused($fieldInFocus, equals: .password)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.gray.brightness(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Button(buttonText) {
                let usernameIsValid = !username.isEmpty
                let passwordIsValid = !password.isEmpty
                
                if usernameIsValid && passwordIsValid {
                    buttonText = "SIGN IN SUCCESS"
                } else if usernameIsValid {
                    fieldInFocus = .password
//                    usernameInFocus = false
//                    passwordInFocus = true
                } else {
                    fieldInFocus = .username
//                    usernameInFocus = true
//                    passwordInFocus = false
                }
            }
        }
        .padding(40)
//        .onAppear(perform: {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                self.usernameInFocus = true
//            }
//        })
    }
}

#Preview {
    ContentView()
}
