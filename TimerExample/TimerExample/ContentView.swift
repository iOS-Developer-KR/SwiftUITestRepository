//
//  ContentView.swift
//  TimerExample
//
//  Created by Taewon Yoon on 4/8/24.
//

import SwiftUI

struct ContentView: View {

    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
//    @State var currentDate: Date = Date()
    
    // Current Time
//    var dateFormatter: DateFormatter {
//       let formatter = DateFormatter()
//        formatter.dateStyle = .medium
//        formatter.timeStyle = .medium
//        return formatter
//    }
    
    
    // Countdown
    /*
    @State var count: Int = 10
    @State var finishedText: String? = nil
    */
    
    // Countdown to date
    @State var timeRemaining: String = ""
    // 앱을 만들 때는 얼만큼 시간이 남았는지를 설정하는 부분입니다.
    let futureDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    
    func updateTimeRemaining() {
        let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDate)
        let hour = remaining.hour ?? 0
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
        timeRemaining = "\(hour):\(minute):\(second)"
    }
    
    
    
    // Animation counter
    @State var count: Int = 0
    

    
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [Color(.purple), Color.accentColor]), center: .center, startRadius: 5, endRadius: 500)
                .ignoresSafeArea()
            
            TabView(selection: $count,
                    content:  {
                Rectangle()
                    .foregroundStyle(.red)
                    .tag(1)
                Rectangle()
                    .foregroundStyle(.blue)
                    .tag(2)
                Rectangle()
                    .foregroundStyle(.green)
                    .tag(3)
                Rectangle()
                    .foregroundStyle(.orange)
                    .tag(4)
                Rectangle()
                    .foregroundStyle(.pink)
                    .tag(5)
            })
            .frame(height: 200)
            .tabViewStyle(PageTabViewStyle())
            
            HStack(spacing: 15) {
                Circle()
                    .offset(y: count == 1 ? -20 : 0)
                Circle()
                    .offset(y: count == 2 ? -20 : 0)
                Circle()
                    .offset(y: count == 3 ? -20 : 0)
                Circle()
                    .offset(y: count == 4 ? -20 : 0)
                Circle()
                    .offset(y: count == 5 ? -20 : 0)
            }
            .frame(width: 200)
            .foregroundStyle(.white)
        }
        .onReceive(timer, perform: { value in
            withAnimation(.easeInOut(duration: 0.5)) {
                count = count == 5 ? 0 : count + 1
            }
            
        })
    }
}

#Preview {
    ContentView()
}
