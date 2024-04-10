//
//  ContentView.swift
//  WeakSelfExample
//
//  Created by Taewon Yoon on 4/7/24.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("count") var count: Int?
    
    init() {
        print("??")
        count = 0
    }
    
    var body: some View {
        NavigationStack {
            NavigationLink {
                WeakSelfSecondScreen()
                    .navigationTitle("Screen 1")
            } label: {
                Text("Navigate")
            }
        }
        .overlay(alignment: .topTrailing) {
            Text("\(count ?? 0)")
                .font(.largeTitle)
                .padding()
                .background(Color.green)
        }
    }
}

struct WeakSelfSecondScreen: View {
    
//    @Environment(WeakSelfSecondScreenViewModel.self) var vm
    @StateObject var vm = WeakSelfSecondScreenViewModel()
    
    var body: some View {
        VStack {
            Text("Second View")
                .font(.largeTitle)
                .foregroundStyle(.red)
            
            if let data = vm.data {
                Text(data)
            }
        }
    }
}

class WeakSelfSecondScreenViewModel: ObservableObject {
    
    @Published var data: String? = nil
    
    init() {
        print("INITIALIZE NOW")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount + 1, forKey: "count")
        getData()
    }
    
    deinit {
        print("DEINITIALIZE NOW")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount - 1, forKey: "count")
    }
    
    func getData() {
//         self.data로 설정하게 되면 WeakSelfSecondScreen 클래스와 강한 참조로 엮이게 된다
//         self.data로 설정하면 data를 사용하기 위해서는 반드시 WeakSelfSecondViewModel이 살아있어야 함을 의미합니다.
//         만일 인터넷으로부터 엄청 많은 데이터를 받아야 하는 상황이 생길 때 유저가 화면에서 특정 동작을 하고 있을 수 있습니다.
//         만일 데이터를 가져오는 동안 유저가 뷰를 돌아다니거나 가져온 데이터가 별로 필요가 없어질때 데이터가 도착했을 수 있습니다.
//        DispatchQueue.global().async {
//            self.data = "NEW DATA!!!"
//        }
        
        // 아래처럼 설정하게 되면 뷰가 사라질 때 deinit이 실행이 안됩니다.
        // 실행이 안되는 이유는 강한 참조를 하고 있기 때문에 self.data 작업이 완료되기 전까지 deinit이 실행되지 않습니다.
        // self.data를 사용하려면 WeakSelfSecondScreenViewModel이 반드시 필요하기 때문에
        // 만약에 8개의 init으로 클래스가 만들어 졌을 경우 8개의 클래스가 작업이 끝나기 전까지 모두 백그라운드에 메모리를 차지하기 때문에
        // 효율적이지 못하고 결국에는 앱 성능에 영향을 미칠 것이다.
//        DispatchQueue.main.asyncAfter(deadline: .now() + 100) {
//            self.data = "NEW DATA!!!"
//        }
        
        // self? 는 작업을 하는 동안에 WeakSelfSecondScreenViewModel 이 반드시 살아있어야 하지는 않는다는 것을 의미합니다
        // 데이터를 다운받는 동작이 오래걸리는 비동기 코드를 사용할 때는 weak self를 사용하는 것이 메모리 누수를 방지할 수 있습니다.
        DispatchQueue.main.asyncAfter(deadline: .now() + 100) {[weak self] in
            self?.data = "NEW DATA!!!"
        }
    }
}

#Preview {
    ContentView()
}
