//
//  ContentView.swift
//  CombineTest2
//
//  Created by Taewon Yoon on 4/10/24.
//

import SwiftUI
import Combine

class AdvancecdCombineDataService {
    
    @Published var basicPublisher: String = ""
    
    // 하나의 값을 wrap하고 값이 바뀔 때마다 새로운 값을 publish합니다
//    let currentValuePublisher = CurrentValueSubject<Int, Never>("first published") // 초기 publish 내용을 적어야한다
    let passThroughPublisher = PassthroughSubject<Int, Error>() //값을 지니고있지 않아도 된다. 메모리 효율이 좀 더 좋다
    
    init() {
        publishFakeData()
    }
    
    // 인터넷으로부터 데이터를 받는 상황을 재현
    private func publishFakeData() {
        let items: [Int] = Array(1..<11) // = ["one", "two", "three"]
        
        for x in items.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(x)) {
                self.passThroughPublisher.send(items[x])
                
                if x == items.indices.last {
                    self.passThroughPublisher.send(completion: .finished)
                }
            }
        }
    }
}

class AdvancecdCombineViewModel: ObservableObject {
    
    @Published var data: [String] = []
    @Published var error: String = ""
    let dataService = AdvancecdCombineDataService()
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        dataService.passThroughPublisher // publisher를 구독한다
        
        // Sequence Operations
        /*
//            .first() // 흐름에서 첫 번째 요소만 빼오기
//            .first(where: { $0 > 4 }) // 4보다 큰것들 중 첫번째것만 빼오기
//            .tryFirst(where: { int in // 에러가 발생할 수 있을 때 사용
//                if int == 3 {
//                    throw URLError(.badServerResponse)
//                }
//                return int > 1
//            })
//            .last() // completion이 finish되지 않으면 값을 계속 기다린다
//            .last(where: { $0 > 4 }) // last는 upstream이 끝나고 나서 만족하는 값을 publish한다
//            .tryLast(where: { int in
//                if int == 3 {
//                    throw URLError(.badServerResponse) // 만약 3이면 error를 throw해서 끊는다
//                }
//                return int > 1 // (last는 upstream이 끝나고 나서 만족하는 값을 publish하므로) 그냥 통과
//            })
//            .dropFirst() // 첫번째 publish값 버리기
//            .dropFirst(3) // 3개 publish값 버리기
//            .drop(while: { $0 < 5 }) // 5보다 작을때까지 버리고 false로 바뀐 순간부터 버리는걸 그만한다
//            .tryDrop(while: { int in // 에러를 throw 할 수 있는 Drop
//                if int == 15 {
//                    throw URLError(.badServerResponse)
//                }
//                return int < 6 // 6일때까지 계속 버리기
//            })
//            .prefix(4) // 앞에서 4개를 가져오기
//            .prefix(while: { $0 < 5 })
//            .tryPrefix(while: )
//            .output(at: 3) // 인덱스로 값 가져오기
//            .output(in: 2..<4) // 인덱스 범위로 값 가져오기
        */
        
        // Mathematic Operations
        /*
//            .max() // 사용하기 위해서는 반드시 .finish를 사용해야합니다. 흐름이 언제 끝나야하는지 알아야하기 때문에
//            .max(by: { int1, int2 in // 1,2  2,3  3,4  4,5 이런식으로 버블 정렬처럼 비교
//                return int1 < int2
//            })
//            .tryMax(by: )
//            .min() // upStream이 완료된 후 가장 작은 값을 반환
//            .min(by: )
//            .tryMin(by: )
        */
        
        // Filter / Reducing Operations
//            .map({ String($0) }) // 값을 String으로 변환
        
            .map( { String($0) })
            .sink { completion in // subscriber를 저장해야한다. store
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = "ERROR: \(error.localizedDescription)"
                }
            } receiveValue: { [weak self] returnedValue in
                self?.data.append(returnedValue) // publisher인 data에 returnedValue를 넣는 것
            }
            .store(in: &cancellables)
    }
}

struct ContentView: View {
    
    @StateObject private var vm = AdvancecdCombineViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(vm.data, id: \.self) {
                    Text($0)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                if !vm.error.isEmpty {
                    Text(vm.error)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
