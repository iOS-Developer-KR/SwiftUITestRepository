//
//  ContentView.swift
//  ProtocolExample
//
//  Created by Taewon Yoon on 4/27/24.
//

import SwiftUI

struct DefaultColorTheme: ColorThemeProtocol {
    let primary: Color = .blue
    let secondary: Color = .white
    let tertiary: Color = .gray
}

struct AlternativeColorTheme: ColorThemeProtocol {
    let primary: Color = .red
    let secondary: Color = .white
    let tertiary: Color = .green
}

struct AnotherColorTheme: ColorThemeProtocol {
    var primary: Color = .blue
    var secondary: Color = .red
    var tertiary: Color = .purple
}

protocol ManyColorThemeProtocol: ColorThemeProtocol, ColorThemeProtocol2 {
    
}

protocol ColorThemeProtocol {
    var primary: Color { get }
    var secondary: Color { get }
    var tertiary: Color { get }
}

protocol ColorThemeProtocol2 {
    var primary: Color { get }
    var secondary: Color { get }
    var tertiary: Color { get }
}

protocol ButtonTextProtocol {
    var buttonText: String { get }
}

protocol ButtonPressedProtocol {
    func buttonPressed()
}

protocol ButtonDataSourceProtocol: ButtonPressedProtocol, ButtonTextProtocol {
    
}

class DefaultDataSource: ButtonDataSourceProtocol {
    var buttonText: String = "Protocols"
    
    func buttonPressed() {
        print("버튼 눌렸다")
    }
}

class AlternativeDataSource: ButtonTextProtocol {
    var buttonText: String = "대체 데이터 소스"
}

struct ContentView: View {

    let colorTheme: ColorThemeProtocol = DefaultColorTheme()
    let dataSource: ButtonDataSourceProtocol = DefaultDataSource()
    
    var body: some View {
        ZStack {
            colorTheme.tertiary
                .ignoresSafeArea()
            
            Text("Protocol Example")
                .font(.headline)
                .foregroundStyle(colorTheme.secondary)
                .padding()
                .background(colorTheme.primary)
                .onTapGesture {
                    dataSource.buttonPressed()
                }
        }
    }
}

#Preview {
    ContentView(/*colorTheme: DefaultColorTheme(), dataSource: DefaultDataSource()*/)
}
