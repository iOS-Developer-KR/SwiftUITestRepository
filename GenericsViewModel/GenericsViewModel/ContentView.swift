//
//  ContentView.swift
//  GenericsViewModel
//
//  Created by Taewon Yoon on 4/12/24.
//

import SwiftUI


struct StringModel {
    let info: String?
    
    func removeInfo() -> StringModel {
        return StringModel(info: nil)
    }
}

struct BoolModel {
    let info: Bool?
    
    func removeInfo() -> BoolModel {
        BoolModel(info: nil)
    }
}

struct GenericModel<T> { // T=type
    let info: T?
    
    func removeInfo() -> GenericModel {
        GenericModel(info: nil)
    }
}

class GenericsViewModel: ObservableObject {
    
    @Published var stringModel = StringModel(info: "Hello world!")
    @Published var boolModel = BoolModel(info: true)
    
    @Published var genericStringModel = GenericModel(info: "Hello world!")
    @Published var genericBoolModel = GenericModel(info: true)
    
    func removeData() {
        stringModel = stringModel.removeInfo()
        boolModel = boolModel.removeInfo()
        genericStringModel = genericStringModel.removeInfo()
        genericBoolModel = genericBoolModel.removeInfo()
    }
}

struct GenericView<T:View>: View { // T는 View 프로토콜을 준수해야지만 사용 될 수 있다
    
    let content: T
    let title: String
    
    var body: some View {
        VStack {
            Text(title)
            content
        }
    }
}

struct ContentView: View {
    
    @StateObject private var vm = GenericsViewModel()
    
    var body: some View {
        VStack {
            GenericView(content: Text("커스텀 뷰"), title: "새로운 뷰")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
