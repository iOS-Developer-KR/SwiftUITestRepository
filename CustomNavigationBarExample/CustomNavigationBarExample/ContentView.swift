//
//  ContentView.swift
//  CustomNavigationBarExample
//
//  Created by Taewon Yoon on 4/23/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.red.ignoresSafeArea()
                
                NavigationLink {
                    Text("Destination")
                        .navigationTitle("Title 2")
                } label: {
                    Text("Navigate")
                }

            }
            .navigationTitle("Nav title here")
        }
    }
}

#Preview {
    ContentView()
}
