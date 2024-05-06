//
//  ContentView.swift
//  QRCodeScanner
//
//  Created by Taewon Yoon on 5/7/24.
//

import SwiftUI
import CodeScanner


struct ContentView: View {
    var body: some View {
        
        CodeScannerView(codeTypes: [.qr], videoCaptureDevice: .default(.builtInTripleCamera, for: .audio, position: .back)) { response in
            switch response {
            case .success(let result):
                print("Found code: \(result.string)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    ContentView()
}
