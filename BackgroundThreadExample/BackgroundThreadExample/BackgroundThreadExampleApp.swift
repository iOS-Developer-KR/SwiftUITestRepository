//
//  BackgroundThreadExampleApp.swift
//  BackgroundThreadExample
//
//  Created by Taewon Yoon on 4/7/24.
//

import SwiftUI

@main
struct BackgroundThreadExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(BackgroundThreadViewModel())
        }
    }
}
