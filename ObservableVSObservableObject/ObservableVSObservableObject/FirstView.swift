//
//  ContentView.swift
//  ObservableVSObservableObject
//
//  Created by Taewon Yoon on 4/10/24.
//

import SwiftUI

class test1: ObservableObject {
    @Published var tmp = false
}

@Observable class test2 {
    var tmp = false
}

struct FirstView: View {
    @StateObject var test = test1()
    
    var body: some View {
        Button(action: {
            print("\(Date().timeIntervalSince1970)")
            test.tmp.toggle()
        }, label: {
            Text("\(test.tmp)")
        })
            .onAppear(perform: {
                print("재시작")
            })
            .onChange(of: test.tmp) { oldValue, newValue in
                print("값이 바뀌었다:\(newValue): \(Date().timeIntervalSince1970)")
            }
    }
}

struct SecondView: View {
    @Environment(test2.self) var test
    
    var body: some View {
        Button(action: {
            print("\(Date().timeIntervalSince1970)")
            test.tmp.toggle()
        }, label: {
            Text("\(test.tmp)")
        })
            .onAppear(perform: {
                print("재시작")
            })
            .onChange(of: test.tmp) { oldValue, newValue in
                print("값이 바뀌었다:\(newValue): \(Date().timeIntervalSince1970)")
            }
    }
}

#Preview {
    FirstView()
}

#Preview {
    SecondView()
        .environment(test2())
}

/*
 값이 바뀌었다:true: 0.0031
 1712718721.510151
 1712718721.51447
 

 값이 바뀌었다:false: 0.003312
 1712718722.341039
 1712718722.344321

 값이 바뀌었다:true: 0.0019
 1712718722.487246
 1712718722.489125

 값이 바뀌었다:false: 
 1712718722.669061
 1712718722.670794

 값이 바뀌었다:true: 
 1712718722.788056
 1712718722.790597

 값이 바뀌었다:false: 
 1712718722.937293
 1712718722.939211
 */


/*

 값이 바뀌었다:true:  0.00263
 1712718870.41194
 1712718870.414547

 값이 바뀌었다:false: 0.03501
 1712718873.618401
 1712718873.6219
 
 값이 바뀌었다:true: 0.022
 1712718874.119189
 1712718874.1214352

 값이 바뀌었다:false:
 1712718874.548266
 1712718874.5501208
 
 값이 바뀌었다:true: 
 1712718875.258936
 1712718875.2606711
 */
