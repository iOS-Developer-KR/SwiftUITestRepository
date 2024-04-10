//
//  ContentView.swift
//  CombineTimer
//
//  Created by Taewon Yoon on 4/9/24.
//

import SwiftUI
import Combine

class SubscriberViewModel: ObservableObject {
    
    @Published var count: Int = 0

    var cancellables = Set<AnyCancellable>() // 여러개의 publisher를 사용할 수 있다
    
    // publisher는 데이터를 publish하고 subscriber를 구현하여 값의 변화를 감지
    @Published var textFieldText: String = "" // 값이 바뀔때마다 publish 되는 것이다 타이머처럼

    @Published var textIsValid: Bool = false

    @Published var showButton: Bool = false
    
    
    init() {
        setUpTimer()
        addTextFieldSubscriber()
        addButtonSubscriber()
    }

    func setUpTimer() {
        Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self]  _ in
                guard let self = self else { return }
                print("시작하는데\(count)")
                self.count += 1

            }
            .store(in: &cancellables)
    }
    
    func addTextFieldSubscriber() {
        $textFieldText
        // deboounce는 텍스틜드를 사용할 때 자주 사용된다
        // 만일 map에 많은 로직이 들어있다면 데이터베이스에 저장하거나 무거운 작업이 있으면 문제가 될 수 있다.
        // 그러기 위해서 0.5초동안 map 로직이 실행되기 전에 딜레이를 주는 것이다
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map { text -> Bool in
                if text.count > 3 {
                    return true
                }
                return false
            }
        // .assign 보다 되도록이면 .sink를 사용한다
//            .assign(to: \.textIsValid, on: self)
        // 사용자가 아이디나 비밀번호같은 경우 텍스트필드를 사용하는데 유용하다
            .sink(receiveValue: { [weak self] isValid in
                self?.textIsValid = isValid
            })
            .store(in: &cancellables)
    }
    
    func addButtonSubscriber() {
        $textIsValid
            .combineLatest($count) // textIsValid와 count Publisher끼리 합치기 // 둘다 가장 마지막으로 published된 값을 가진다.
            .sink { [weak self] (isValid, count) in
                guard let self = self else { return }
                if isValid && count >= 10 {
                    self.showButton = true
                } else {
                    self.showButton = false
                }
            }
            .store(in: &cancellables)
    }
    
}

struct ContentView: View {
    @StateObject var vm = SubscriberViewModel()
    
    var body: some View {
        VStack {
            Text("\(vm.count)")
            
            Text("\(vm.textIsValid)")

            TextField("입력", text: $vm.textFieldText)
                .padding(.leading)
                .frame(height: 55)
                .font(.headline)
                .background(Color.secondary)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    ZStack {
                        Image(systemName: "xmark")
                            .foregroundStyle(.red)
                            .opacity(
                                vm.textFieldText.count < 1 ? 0.0 :
                                vm.textIsValid ? 0.0 : 1.0)
                        
                        Image(systemName: "checkmark")
                            .foregroundStyle(.green)
                            .opacity(vm.textIsValid ? 1.0 : 0.0)
                    }
                        .font(.headline)
                        .padding(.trailing)
                        
                    , alignment: .trailing
                )
            
            Button(action: {
                
            }, label: {
                Text("제출")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .opacity(vm.showButton ? 1.0 : 0.5)
            })
            .disabled(!vm.showButton)
        }
        .padding()
    }
}

#Preview {
    ContentView()
//        .environment(SubscriberViewModel())
}
