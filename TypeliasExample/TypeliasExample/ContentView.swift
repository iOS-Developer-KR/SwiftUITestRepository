//
//  ContentView.swift
//  TypeliasExample
//
//  Created by Taewon Yoon on 4/8/24.
//

import SwiftUI

struct MovieModel {
    let title: String
    let director: String
    let count: Int
}

//struct TVModel {
//    let title: String
//    let director: String
//    let count: Int
//}

typealias TVModel = MovieModel


struct ContentView: View {
    
//    @State var item: MovieModel = MovieModel(title: "Title", director: "Yoon", count: 5)
    @State var item: TVModel = TVModel(title: "TV Title", director: "KIM", count: 10)
    var body: some View {
        VStack {
            Text(item.title)
            Text(item.director)
            Text("\(item.count)")
        }
    }
}

#Preview {
    ContentView()
}
