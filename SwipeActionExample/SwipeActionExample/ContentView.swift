//
//  ContentView.swift
//  SwipeActionExample
//
//  Created by Taewon Yoon on 4/6/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var fruits: [String] = ["apple", "orange", "bananna", "peach"]
    var body: some View {
        List {
            ForEach(fruits, id: \.self) {
                Text($0.capitalized)
                    .swipeActions(edge: .trailing,
                                  allowsFullSwipe: true) {
                        Button(action: {
                            
                        }, label: {
                            Text("기록")
                        })
                        .tint(.green)
                        Button(action: {
                            
                        }, label: {
                            Text("저장")
                        })
                        .tint(.blue)
                        Button(action: {
                            
                        }, label: {
                            Text("삭제")
                        })
                        .tint(.red)
                    }
                  .swipeActions(edge: .leading,
                                allowsFullSwipe: true) {
                      Button(action: {
                          
                      }, label: {
                          Text("공유")
                      })
                      .tint(.yellow)
                      
                  }
            }
            
        }
    }
}

#Preview {
    ContentView()
}
