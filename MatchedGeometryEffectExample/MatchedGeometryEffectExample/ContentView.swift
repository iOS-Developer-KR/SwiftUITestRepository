//
//  ContentView.swift
//  MatchedGeometryEffectExample
//
//  Created by Taewon Yoon on 4/12/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isClicked: Bool = false
    @Namespace private var namespace
    
    var body: some View {
        VStack {
            if !isClicked {
                RoundedRectangle(cornerRadius: 25.0)
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
                    .frame(width: 100, height: 100)

            }
            
            Spacer()
            
            RoundedRectangle(cornerRadius: 25.0)
                .matchedGeometryEffect(id: "rectangle", in: namespace)
                .frame(width: 300, height: 200)
                
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.red)
        .onTapGesture {
            withAnimation(.easeInOut) {
                isClicked.toggle()
            }
        }
    }
}

#Preview {
    ContentView()
}

struct ContentView2: View {
    let categories: [String] = ["Home", "popular", "Saved"]
    @State private var selected: String = ""
    @Namespace private var namespace
    
    var body: some View {
        HStack {
            ForEach(categories, id: \.self) { category in
                ZStack(alignment: .bottom) {
                    if selected == category {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.red.opacity(0.5))
                            .matchedGeometryEffect(id: "category_background", in: namespace)
                            .frame(width: 35, height: 2)
                            .offset(y: 10)
                    }
                    
                    Text(category)
                        .foregroundStyle(selected == category ? .red : .black)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .onTapGesture {
                    withAnimation(.spring()) {
                        selected = category
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView2()
}

extension UIWindow {
    static var current: UIWindow? {
        for scene in UIApplication.shared.connectedScenes {
            guard let windowScene = scene as? UIWindowScene else { continue }
            for window in windowScene.windows {
                if window.isKeyWindow { return window }
            }
        }
        return nil
    }
}


extension UIScreen {
    static var current: UIScreen? {
        UIWindow.current?.screen
    }
}
