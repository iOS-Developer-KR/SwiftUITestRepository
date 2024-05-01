//
//  ContentView.swift
//  CircleRotationExample
//
//  Created by Taewon Yoon on 5/1/24.
//

import SwiftUI

struct CircleView: View {
    
    @State var percent: CGFloat = 0
    @State var count: Int = 0
    
    var body: some View {
        Loader(percent: $percent, count: $count)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    withAnimation(Animation.easeInOut(duration: 1.0)) {
                        percent = 0.33
                        count = 1
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation(Animation.easeInOut(duration: 1.0)) {
                        percent = 0.66
                        count = 2
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(Animation.easeInOut(duration: 1.0)) {
                        percent = 1
                        count = 3
                    }
                }
            }
    }
}

struct CircleView_Previews: PreviewProvider {
    static var previews: some View {
        CircleView()
    }
}


struct Loader: View {
    
    @Binding var percent: CGFloat
    @Binding var count: Int
    
    var colors: [Color] = [
        Color(hex: "#AAFFA9"),
        Color(hex: "#11FFBD")
    ]
    
    let circleHeight: CGFloat = 300
     
    var body: some View {
        let pinHeight = circleHeight * 0.1
        let completion = percent
        Circle()
            .trim(from: 0, to: completion)
            .stroke(style: StrokeStyle(lineWidth: 22, lineCap: .butt, lineJoin: .round, miterLimit: 50))
            .fill(AngularGradient(gradient: .init(colors: colors), center: .center, startAngle: .zero, endAngle: .init(degrees: 360)))
            .rotationEffect(.degrees(-90))
            .frame(width: circleHeight, height: circleHeight)
            .overlay(
                Text(String(count))
                    .animation(nil)
            )
            .overlay(
                Circle()
                    .foregroundStyle(.red)
                    .frame(width: pinHeight, height: pinHeight)
                    .offset(y: -pinHeight / 2)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .rotationEffect(Angle(degrees: 360 * Double(completion)))
                    
            )
    }
}

extension Color {
  init(hex: String) {
    let scanner = Scanner(string: hex)
    _ = scanner.scanString("#")
    
    var rgb: UInt64 = 0
    scanner.scanHexInt64(&rgb)
    
    let r = Double((rgb >> 16) & 0xFF) / 255.0
    let g = Double((rgb >>  8) & 0xFF) / 255.0
    let b = Double((rgb >>  0) & 0xFF) / 255.0
    self.init(red: r, green: g, blue: b)
  }
}
