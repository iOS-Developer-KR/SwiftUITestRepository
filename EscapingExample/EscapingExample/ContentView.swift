//
//  ContentView.swift
//  EscapingExample
//
//  Created by Taewon Yoon on 4/8/24.
//

import SwiftUI

@Observable class EscapingViewModel {
    var text: String = "Hello"
    
    func getData() {
        
    }
    

}

func downloadData(completionHandler: @escaping DownloadCompletion) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
        let result = DownloadResult(data: "New Data!")
        completionHandler(result)
    }
}

struct DownloadResult {
    let data: String
}

typealias DownloadCompletion = (DownloadResult) -> ()

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
