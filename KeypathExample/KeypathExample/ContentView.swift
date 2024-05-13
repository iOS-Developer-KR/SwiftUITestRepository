//
//  ContentView.swift
//  KeypathExample
//
//  Created by Taewon Yoon on 5/13/24.
//

import SwiftUI

struct MyDataModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let count: Int
    let date: Date
}

//struct MovieTitle {
//    let primary: String
//    let secondary: String
//}

//MARK: MyDataModel 한정 사용 가능
//extension Array where Element == MyDataModel {
//    func customSorted<T: Comparable>(keyPath: KeyPath<MyDataModel, T>) -> [Element] {
//        self.sorted { item1, item2 in
//            return item1[keyPath: keyPath] < item2[keyPath: keyPath]
//        }
//    }
//}

//MARK: T 모든 타입 사용 가능
extension Array {
    
    mutating func sortByKeyPath<T: Comparable>(_ keyPath: KeyPath<Element, T>, ascending: Bool = true) {
        self.sort { item1, item2 in
            let value1 = item1[keyPath: keyPath]
            let value2 = item2[keyPath: keyPath]
            
            return ascending ? (value1 < value2) : (value1 > value2)
        }
    }
    
    func sortedByKeyPath<T: Comparable>(_ keyPath: KeyPath<Element, T>, ascending: Bool = true) -> [Element] {
        self.sorted { item1, item2 in
            let value1 = item1[keyPath: keyPath]
            let value2 = item2[keyPath: keyPath]
            
            return ascending ? (value1 < value2) : (value1 > value2)
        }
    }
}

struct ContentView: View {
    
    @State private var dataArray: [MyDataModel] = []
    
    var body: some View {
        VStack {
            List {
                ForEach(dataArray) { item in
                    VStack(alignment: .leading) {
                        Text(item.id)
                        Text(item.title)
                        Text("\(item.count)")
                        Text(item.date.description)
                    }
                    .font(.headline)
                }
            }
            .onAppear {
                var array = [
                    MyDataModel(title: "Three", count: 3, date: .distantFuture),
                    MyDataModel(title: "One", count: 1, date: .now),
                    MyDataModel(title: "Two", count: 2, date: .distantPast)
                ]
                
                //let newArray = array.sorted { item1, item2 in
                ////return item1.count < item2.count
                //return item1[keyPath: \.count] < item2[keyPath: \.count]
                //}
                
                //let title = item.title
                //let title2 = item[keyPath: \.title]
                //screenTitle = title2
                
                // let newArray = array.sortedByKeyPath(\.title)
                
                array.sortByKeyPath(\.count)
                
                dataArray = array
            }
        }
    }
}

#Preview {
    ContentView()
}
