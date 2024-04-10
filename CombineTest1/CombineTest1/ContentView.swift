//
//  ContentView.swift
//  CombineTest1
//
//  Created by Taewon Yoon on 4/10/24.
//

import SwiftUI
import Combine

class TextFieldViewModel: ObservableObject {
    @Published var text1 = ""
    @Published var text2 = ""
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        addTextFieldSubcriber()
    }
    
    func addTextFieldSubcriber() {
        $text1
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { [weak self] value in
                print("체크중")
                self?.text2 = value
            }
            .store(in: &cancellables)
    }
}

struct ContentView: View {
    
    @StateObject var vm = TextFieldViewModel()

    var body: some View {
        VStack {
            TextField("1번째", text: $vm.text1)
            Text(vm.text2)
        }
    }
}

#Preview {
    ContentView()
}
