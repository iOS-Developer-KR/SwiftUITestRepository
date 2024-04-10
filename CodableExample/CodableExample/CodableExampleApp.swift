//
//  CodableExampleApp.swift
//  CodableExample
//
//  Created by Taewon Yoon on 4/8/24.
//

import SwiftUI

@main
struct CodableExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(CodableViewModel())
        }
    }
}
