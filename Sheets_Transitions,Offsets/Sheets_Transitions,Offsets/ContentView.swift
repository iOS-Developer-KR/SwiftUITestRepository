//
//  ContentView.swift
//  Sheets_Transitions,Offsets
//
//  Created by Taewon Yoon on 4/6/24.
//

// sheets
// animations
// transitions

import SwiftUI

struct ContentView: View {
    
    @State var showNewScreen: Bool = false
    let window = UIApplication.shared.connectedScenes.first as! UIWindowScene
    
    var body: some View {
        ZStack {
            Color.orange
                .ignoresSafeArea()
            
            VStack {
                Button("BUTTON") {
//                    showNewScreen = true
                    withAnimation(.spring) {
                        showNewScreen = true
                    }
                }
                Spacer()
            }
            // METHOD 1 - SHEET
//            .sheet(isPresented: $showNewScreen, content: {
//                NewScreen()
//            })
            
            // METHOD 2 - TRANSITION
//            ZStack {
//                if showNewScreen {
//                    NewScreen(showNewScreen: $showNewScreen)
//                        .padding(.top, 100)
//                        .transition(.move(edge: .top))
//                }
//            }
//            .zIndex(2.0)
            
            // METHOD 3 - ANIMATION OFFSET
            
            NewScreen(showNewScreen: $showNewScreen)
                .padding(.top, 100)
                .offset(y: showNewScreen ? 0 : -window.screen.bounds.height)
            
        }
    }
}

struct NewScreen: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var showNewScreen: Bool
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.purple
                .ignoresSafeArea()
            
            Button(action: {
//                dismiss()
                withAnimation(.spring) {
                    showNewScreen.toggle()
                }
            }, label: {
                Image(systemName: "xmark")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .padding(20)
            })
        }
    }
}

#Preview {
    ContentView()
}
