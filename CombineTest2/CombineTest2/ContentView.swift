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
    let boolPublisher = PassthroughSubject<Bool, Error>()
    let intPublisher = PassthroughSubject<Int, Error>()
    
    init() {
        publishFakeData()
    }
    
    // 인터넷으로부터 데이터를 받는 상황을 재현
    private func publishFakeData() {
        let items: [Int] = [1,2,3,4,5,6,7,8,9,10] // = ["one", "two", "three"]
        
        for x in items.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(x)) {
                self.passThroughPublisher.send(items[x])
                
                if (x > 4 && x < 8) {
                    self.boolPublisher.send(true)
                    self.intPublisher.send(999)
                } else {
                    self.boolPublisher.send(false)
                }
                
                if x == items.indices.last {
                    self.passThroughPublisher.send(completion: .finished)
                }
            }
        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
//            self.passThroughPublisher.send(1)
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            self.passThroughPublisher.send(1)
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//            self.passThroughPublisher.send(1)
//        }
        
    }
}

class AdvancecdCombineViewModel: ObservableObject {
    
    @Published var data: [String] = []
    @Published var dataBool: [Bool] = []
    @Published var error: String = ""
    let dataService = AdvancecdCombineDataService()
    
    var cancellables = Set<AnyCancellable>()
    let multicastPublisher = PassthroughSubject<Int, Error>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        
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
        /*
            //.map({ String($0) }) // 값을 String으로 변환
            //.tryMap({ int in
            //    if int == 5 {
            //        throw URLError(.badServerResponse)
            //    }
            //    return String(int)
            //})
            //.compactMap({ int in // 문제가 생기면 그 값을 무시하는 것
            //    if int == 5 {
            //        return nil
            //    }
            //    return String(int)
            //})
            //.tryCompactMap()
            //.filter({ ($0 > 3) && ($0 < 7) })
            //.tryFilter()
            //.removeDuplicates() // 앞뒤로 값이 똑같을때 제거. 2 3 4 4 -> 4번째 4제거, 2 3 4 5 4 -> 아무것도 제거 안함
            //.removeDuplicates(by: { int1, int2 in // 제거 조건을 설정
            //    return int1 == int2
            //})
            //.tryRemoveDuplicates(by: )
            //.replaceNil(with: 5) // let items: [Int?] = [1,2,3,4,nil,6,7,8,9,10]
            //.replaceEmpty(with: <#T##Int#>) // 받은 값이 비어있을 때
            //.replaceError(with: "replaceError로 대신 처리") // try에서 에러를 throw할 때 에러를 대체하는데 사용
            //.scan(0, { $0 + $1 }) // 0은 초깃값  // 1,2,3,4,5 -> 1,3,6,10,15 // 현재까지 값끼리 더한 값 + 현재 값
            //.scan(0, +) // 위에 scan을 극한으로 줄인 것
            //.tryScan(,)
            //.reduce(0, { existingValue, newValue in
            //    return existingValue + newValue
            //})
            //.reduce(0, +) // 모든 값을 더해서 하나의 값으로 publish
            //.collect() // 데이터가 publish로부터 모든 값들을 collect한 후 값을 publish한다
            //.collect(3) // 3개의 데이터가 collect 됐을 떄 값을 publish
            //.allSatisfy({ $0 == 5 }) // 모든 값이 조건에 일치하면 true를 아니면 false를 반환
            //.tryAllSatisfy()
        */
        
        // Timing Operations
        /*
            //.debounce(for: 0.75, scheduler: DispatchQueue.main)//publisher로부터 받는 값을 감시
            //.delay(for: 2, scheduler: DispatchQueue.main) // 시작을 2초 늦게 한다
            //.measureInterval(using: DispatchQueue.main) // publish되는 시간 간격을 알 수 있으며 디버깅할 때 사용할 수 있다
            //.map({ stride in
            //    return "\(stride.timeInterval)"
            //})
            //.throttle(for: 2, scheduler: DispatchQueue.main, latest: true) // 2초 뒤에 publish되며 latest를 true로 하면 이전값을 무시하고 가장 최근 값을 나타내며 latest를 false로 하면 가장 마지막으로 publish돤 다음값을 publish합니다. 데이터를 바로 로딩하고싶지 않을 때 사용될 수 있다.
            //.retry(3) //에러가 발생해도 3번 시도하기, 3번해도 안되면 completion에서 .failure를 수행
            //.timeout(0.5, scheduler: DispatchQueue.main) // 처음 publish후 0.5초안에 다른 값이 스트림에 없으면 finish
        */
        
        // Mutiple Publishers / Subscribers
        /*
            //.combineLatest(dataService.boolPublisher)
            //.compactMap({ (int, bool) in // 위에서도 published 되고 있으므로 중복해서 값이 publish
            //    if bool {
            //        return String(int)
            //    }
            //    return nil
            //})
            //.compactMap({ $1 ? String($0) : nil })
            //.removeDuplicates()
            //.combineLatest(dataService.boolPublisher, dataService.intPublisher)
            //.compactMap({ (int1, bool, int2) in
            //    if bool {
            //        return String(int1)
            //    }
            //    return "n\a"
            //})
            //.merge(with: dataService.intPublisher) // 데이터 합치기
            //.zip(dataService.boolPublisher, dataService.intPublisher)
            //.map({ tuple in // compactMap은 각각의 publish를 다루지만 zip은 하나의 tuple로
            //    return String(tuple.0) + tuple.1.description + String(tuple.2)
            //})
            //.tryMap({ int in
            //    if int == 5 {
            //        throw URLError(.badServerResponse)
            //    }
            //    return int
            //})
            //.catch({ error in
            //    return self.dataService.intPublisher
            //})
        */
        
        let sharedPublisher = dataService.passThroughPublisher
            //.dropFirst(3)
            .share()
            //.multicast { // publish된 데이터를 PassthroughSubject에 저장
            //    PassthroughSubject<Int, Error>()
            //}
            .multicast(subject: multicastPublisher)
        
//        dataService.passThroughPublisher // publisher를 구독한다
        sharedPublisher
            .map( { String($0) })
            .sink { completion in // subscriber를 저장해야한다. store
                switch completion {
                case .finished:
//                    print("끝")
                    break
                case .failure(let error):
                    self.error = "ERROR: \(error.localizedDescription)"
                }
            } receiveValue: { [weak self] returnedValue in
                self?.data.append(returnedValue) // publisher인 data에 returnedValue를 넣는 것
            }
            .store(in: &cancellables)
        
//        dataService.passThroughPublisher // publisher를 구독한다
        sharedPublisher
            .map( { $0 > 5 ? true : false })
            .sink { completion in // subscriber를 저장해야한다. store
                switch completion {
                case .finished:
//                    print("끝")
                    break
                case .failure(let error):
                    self.error = "ERROR: \(error.localizedDescription)"
                }
            } receiveValue: { [weak self] returnedValue in
                self?.dataBool.append(returnedValue) // publisher인 data에 returnedValue를 넣는 것
            }
            .store(in: &cancellables)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { // 특정 시간에 publish 연결하기
            sharedPublisher
                .connect()
                .store(in: &self.cancellables)
        }
    }
}

struct ContentView: View {
    
    @StateObject private var vm = AdvancecdCombineViewModel()
    
    var body: some View {
        ScrollView {
            HStack {
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
                VStack {
                    ForEach(vm.dataBool, id: \.self) {
                        Text($0.description)
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
}

#Preview {
    ContentView()
}
