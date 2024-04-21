//
//  DownLoadWithCombineExampleApp.swift
//  DownLoadWithCombineExample
//
//  Created by Taewon Yoon on 4/21/24.
//

import SwiftUI

@main
struct DownLoadWithCombineExampleApp: App {
    @State var downloadCombineViewModel = DownloadWithCombineViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(downloadCombineViewModel)
        }
    }
}
