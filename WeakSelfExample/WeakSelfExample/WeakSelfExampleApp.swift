//
//  WeakSelfExampleApp.swift
//  WeakSelfExample
//
//  Created by Taewon Yoon on 4/7/24.
//

import SwiftUI

@main
struct WeakSelfExampleApp: App {
    @State var vm = WeakSelfSecondScreenViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
//                .environment(vm)
        }
    }
}
