//
//  ContentView.swift
//  BackgroundThreadExample
//
//  Created by Taewon Yoon on 4/7/24.
//

import SwiftUI


@Observable class BackgroundThreadViewModel {
    
    var dataArray: [String] = []
    
    func fetchData() {
        // 백그라운드 스레드에서 다운로드하기
        DispatchQueue.global(qos: .userInteractive).async {
            let newData = self.downloadData()
            
            print("CHECK 1: \(Thread.isMainThread)")
            print("CHECK 1: \(Thread.current)")
            // 메인 스레드에서 UI 변경하기
            DispatchQueue.main.async {
                self.dataArray = newData
                print("CHECK 2: \(Thread.isMainThread)")
                print("CHECK 2: \(Thread.current)")
            }
        }
    }
    
    func downloadData() -> [String] {
        var data: [String] = []
        
        for x in 0..<100 {
            data.append("\(x)")
        }
        return data
    }
}

struct ContentView: View {
    
    @Environment(BackgroundThreadViewModel.self) var vm
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                Text("LOAD DATA")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.fetchData()
                    }
                
                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundStyle(.red)
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(BackgroundThreadViewModel())
}
