//
//  FireBaseExampleApp.swift
//  FireBaseExample
//
//  Created by Taewon Yoon on 4/12/24.
//

import SwiftUI
import Firebase

@main
struct FireBaseExampleApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State private var signInEmailViewModel = SignInEmailViewModel()
    @State private var settingsViewModel = SettingsViewModel()
    
    init() {
        // FirebaseApp.configure() // AppDelegate 없이 시작
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RootView()
            }
        }
        .environment(signInEmailViewModel)
        .environment(settingsViewModel)
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

