//
//  ContentView.swift
//  HashableExample
//
//  Created by Taewon Yoon on 4/24/24.
//

import SwiftUI

struct CustomModel: Hashable {
    let name: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

struct ContentView: View {
    
    let data: [CustomModel] = [
        CustomModel(name: "ONE"),
        CustomModel(name: "TWO"),
        CustomModel(name: "THREE"),
        CustomModel(name: "FOUR"),
        CustomModel(name: "FIVE")
    ]
    var body: some View {
        ScrollView {
            VStack {
                ForEach(data, id: \.self) { item in
                    Text(item.name)
                        .font(.headline)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
