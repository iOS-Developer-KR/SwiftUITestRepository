//
//  AsyncStreamViewModel.swift
//  AsyncStreamExample
//
//  Created by Taewon Yoon on 4/6/24.
//

import SwiftUI

class AsyncStreamDataManager {
    // Closure를 사용하지 않아도 된다는 점이 있다.
    func getAsyncStream() -> AsyncThrowingStream<Int, Error> {
        AsyncThrowingStream { [weak self] continuation in
            self?.getFakeData(newValue: { value in
                continuation.yield(value)
            }, onFinish: { error in
                    continuation.finish(throwing: error)
            })
        }
    }
    
    // DispatchQueue는 작업이 끝난 뒤에 비동기적으로 값을 반환할 수 있기 때문에 @escaping을 사용합니다.
    func getFakeData(
        newValue: @escaping (_ value: Int) -> Void,
        onFinish: @escaping (_ error: Error?) -> Void
    ) {
        let items: [Int] = [1,2,3,4,5,6,7,8,9,10]
        
        for item in items {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(item)) {
                newValue(item)
                print("NEW DATA: \(item)")
                
                if item == items.last {
                    onFinish(nil)
                }
            }
        }
    }
}

@MainActor
@Observable final class AsyncStreamViewModel {
    
    let manager = AsyncStreamDataManager()
    var currentNumber: Int = 0
    
    func onAppear() {
//        manager.getFakeData { [weak self] value in
//            self?.currentNumber = value
//        }
        Task {
            do {
                for try await value in manager.getAsyncStream().dropFirst(2) {
                    currentNumber = value
                }
            } catch {
                print(error)
            }
        }
    }
    
}

struct AsyncStreamView: View {
    
    @Environment(AsyncStreamViewModel.self) var asyncStreamViewModel: AsyncStreamViewModel
    
    var body: some View {
        Text("\(asyncStreamViewModel.currentNumber)")
            .onAppear(perform: {
                asyncStreamViewModel.onAppear()
            })
    }
}

#Preview {
    AsyncStreamView()
        .environment(AsyncStreamViewModel())
}
