//
//  ContentView.swift
//  RotationGestureExample
//
//  Created by Taewon Yoon on 4/12/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var angle: Angle = Angle(degrees: 0)
    
    var body: some View {
        Text("iOS-Developer")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundStyle(.white)
            .padding(50)
            .background(Color.blue)
            .rotationEffect(angle)
            .gesture(
                RotationGesture()
                    .onChanged({ value in
                        angle = value
                    })
                    .onEnded({ value in
                        angle = Angle(degrees: 0)
                    })
            )
    }
}

#Preview {
    ContentView()
}
