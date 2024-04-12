//
//  ContentView.swift
//  onLongPressGestureExample
//
//  Created by Taewon Yoon on 4/12/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var isComplete: Bool = false
    @State var isSuccess: Bool = false
    
    var body: some View {
        Rectangle()
            .fill(isSuccess ? .green : .blue)
            .frame(maxWidth: isComplete ? .infinity : 0)
            .frame(height: 55)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.gray)
        
        Text("길게 누르세요")
            .foregroundStyle(.white)
            .padding()
            .background(.black)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 50) {
                isSuccess = true
            } onPressingChanged: { isPressing in
                if isPressing {
                    withAnimation(.easeInOut(duration: 1.0)) {
                        isComplete.toggle()
                    }
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        if !isSuccess {
                            withAnimation(.easeInOut) {
                                isComplete.toggle()
                            }
                        }
                    }
                }
            }
        
        Button(action: {
            isComplete = false
            isSuccess = false
        }, label: {
            Text("리셋")
        })
    }
}

#Preview {
    ContentView()
}
