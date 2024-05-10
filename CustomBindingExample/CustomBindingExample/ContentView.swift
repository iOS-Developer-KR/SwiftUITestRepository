//
//  ContentView.swift
//  CustomBindingExample
//
//  Created by Taewon Yoon on 5/10/24.
//

import SwiftUI

extension Binding where Value == Bool {
    
    init<T>(value: Binding<T?>) {
        self.init {
            value.wrappedValue != nil
        } set: { newValue in
            if !newValue {
                value.wrappedValue = nil
            }
        }
    }
}

struct ContentView: View {
    
    @State var title: String = "Start"
    
    @State private var errorTitle: String? = nil
    @State private var showError: Bool = false
    
    var body: some View {
        VStack {
            
//            ChildView(title: $title)
            
//            ChildView2(title: title) { newTitle in
//                title = newTitle
//            }
            
            ChildView3(title: Binding(get: {
                return title
            }, set: { newValue in
                title = newValue
            }))
            
            Button("클릭") {
                errorTitle = "새로운 에러"
//                showError.toggle()
            }
        }
        .alert(errorTitle ?? "Error", isPresented: Binding(value: $errorTitle)) {
            Button("확인") {
                
            }
        }
//        .alert(errorTitle ?? "Error", isPresented: Binding(get: {
//            return errorTitle != nil ? true : false
//        }, set: { newValue in
//            errorTitle = nil
//        })) {
//            Button("확인") {
//                
//            }
//        }
        
        
//        .alert(errorTitle ?? "Error", isPresented: $showError) {
//            Button("확인") {
//
//            }
//        }
    }
}

struct ChildView: View {
    
    @Binding var title: String
    
    var body: some View {
        Text(title)
            .onAppear {
                //                title = "NEW TITLE"
            }
    }
    
}

struct ChildView2: View {
    
    let title: String
    let setTitle: (String) -> Void
    
    var body: some View {
        Text(title)
            .onAppear {
                setTitle("NEW TITLE 2")
            }
    }
}

struct ChildView3: View {
    
    let title: Binding<String>
    
    var body: some View {
        Text(title.wrappedValue)
            .onAppear {
                title.wrappedValue = "NEW TITLE3"
            }
    }
}


#Preview {
    ContentView()
}
