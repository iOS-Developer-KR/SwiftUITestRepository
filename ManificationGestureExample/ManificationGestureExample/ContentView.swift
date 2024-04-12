//
//  ContentView.swift
//  ManificationGestureExample
//
//  Created by Taewon Yoon on 4/12/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var currentAmout: CGFloat = 0
    @State var lastAmount: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Circle().frame(width: 35, height: 35)
                Text("iOS-Developer")
                Spacer()
                Image(systemName: "ellipsis")
            }
            .padding(.horizontal)
            Rectangle()
                .frame(height: 300)
                .scaleEffect(1 + currentAmout)
                .gesture(
                    MagnifyGesture()
                        .onChanged { value in
                            currentAmout = value.magnification - 1.0
                        }
                        .onEnded({ value in
                            currentAmout = 0
                        })
                )
        }
    }
}

#Preview {
    ContentView()
}
