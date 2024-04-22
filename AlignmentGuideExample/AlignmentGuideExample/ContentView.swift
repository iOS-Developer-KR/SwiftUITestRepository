//
//  ContentView.swift
//  AlignmentGuideExample
//
//  Created by Taewon Yoon on 4/21/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading, content: {
            Text("Hello world!")
                .background(.blue)
//                .alignmentGuide(.leading, computeValue: { dimension in
//                    return dimension.width
//                })
            
            Text("This is some other text!")
                .background(.red)
        })
        .background(.orange)
    }
}

struct AlignmentChildView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            row(title: "Row 1", showIcon: false)
            row(title: "Row 2", showIcon: true)
            row(title: "Row 3", showIcon: false)
        }
        .padding(16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 10)
        .padding(40)
    }
    
    private func row(title: String, showIcon: Bool) -> some View {
        HStack(spacing: 10, content: {
            if showIcon {
                Image(systemName: "info.circle")
                    .frame(width: 30, height: 30)
            }
            
            Text(title)
            
            Spacer()
        })
        .background(.red)
        .alignmentGuide(.leading, computeValue: { dimension in
            return showIcon ? 40 : 0
        })
    }
}

#Preview {
//    ContentView()
    AlignmentChildView()
}
