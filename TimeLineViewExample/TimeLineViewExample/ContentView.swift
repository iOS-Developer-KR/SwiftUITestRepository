//
//  ContentView.swift
//  TimeLineViewExample
//
//  Created by Taewon Yoon on 5/6/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var startTime: Date = .now
    @State private var pauseAnimation: Bool = false
    
    var body: some View {
        VStack {
            
            TimelineView(.animation(minimumInterval: 1, paused: pauseAnimation)) { context in
                
                Text("\(context.date)")
                
//                let seconds = Calendar.current.component(.second, from: context.date)
                
                let seconds = context.date.timeIntervalSince(startTime)
                Text("\(seconds)")

                Rectangle()
                    .frame(
                        width: (Int(seconds) % 2 == 0) ? 200 : 400,
                        height: 100
                    )
                    .animation(.spring(), value: seconds)
            }
            
            TimelineView(.animation(minimumInterval: 0.1)) { TimelineViewDefaultContext in
                Text("\(TimelineViewDefaultContext.date)")
                if TimelineViewDefaultContext.cadence == .live {
                    Text("Cadence: Live")
                } else if TimelineViewDefaultContext.cadence == .minutes {
                    Text("Cadence: Minutes")
                } else if TimelineViewDefaultContext.cadence == .seconds {
                    Text("Cadence: Seconds")
                }
                
            }
            
            Button(pauseAnimation ? "PLAY" : "PAUSE") {
                pauseAnimation.toggle()
            }
        }
    }
}

#Preview {
    ContentView()
}

//                if context.cadence == .plus {
//                    Text("Cadence: Live")
//                } else if context.cadence == .minutes {
//                    Text("Cadence: Minutes")
//                } else if context.cadence == .seconds {
//                    Text("Cadence: Seconds")
//                }
