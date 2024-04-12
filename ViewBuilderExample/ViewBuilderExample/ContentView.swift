//
//  ContentView.swift
//  ViewBuilderExample
//
//  Created by Taewon Yoon on 4/12/24.
//

import SwiftUI

struct HeaderViewRegular: View {
    
    let title: String
    let description: String?
    let iconName: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            if let description = description {
                Text(description)
                    .font(.callout)
            }
            if let iconName = iconName {
                Image(systemName: iconName)
            }
            
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct HeaderViewGeneric<Content: View>: View {
    
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            content
            
            
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct CustomHStack<Content:View>:View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        HStack {
            content
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HeaderViewRegular(title: "새로운 제목", description: "설명", iconName: "heart.fill")
            
            HeaderViewRegular(title: "새로운 제목2", description: "설명2", iconName: nil)
            
            HeaderViewGeneric(title: "Generic 제목") {
                VStack {
                    Image(systemName: "heart.fill")
                    Text("Generic 설명")
                    Image(systemName: "heart.fill")
                }
            }
            
            CustomHStack {
                Text("HStack 1")
                Text("HStack 2")
                Text("HStack 3")
            }.padding()
            
            HStack {
                Text("HStack 1")
                Text("HStack 2")
                Text("HStack 3")
            }.padding()
            
            Spacer()
        }
    }
}

#Preview {
    //    ContentView()
    LocalViewBuilder(type: .three)
}

struct LocalViewBuilder: View {
    
    enum ViewType {
        case one, two, three
    }
    
    let type: ViewType
    
    var body: some View {
        VStack {
            headerSection
        }
    }
    
    @ViewBuilder private var headerSection: some View {
        switch type {
        case .one:
            viewOne
        case .two:
            viewTwo
        case .three:
            viewThree
            
        }
    }
    
    private var viewOne: some View {
        Text("One!")
    }
    
    private var viewTwo: some View {
        VStack {
            Text("Two")
            Image(systemName: "heart.fill")
        }
    }
    
    private var viewThree: some View {
        Image(systemName: "heart.fill")
    }
}
