import UIKit
import Combine

//let passthroughSubject = PassthroughSubject<String, Never>()
//let subscriber = passthroughSubject.sink(receiveValue: {
//    print($0)
//})
//passthroughSubject.send("안녕")
//passthroughSubject.send("Zedd")


class TestSubscriber: Subscriber {
    typealias Input = String
    typealias Failure = Never
    
    func receive(subscription: any Subscription) {
        print("구독 시작했을 때 실행되는 함수로 item을 요청할 수 있다")
        subscription.request(.unlimited)
    }
    
    func receive(_ input: String) -> Subscribers.Demand {
        print("받은 값:\(input)")
        return .none // publisher에 요청할 item의 개수 0
        //        return .unlimited // publisher에 요청할 item의 개수 제한 없음
        //        return .max(0) // publisher에 요청할 item의 최대 개수 제한
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        print("값 받기 완료")
    }
}

//let publisher = Just("저스트")
//publisher.subscribe(JustSubscriber())

//let publisher = Publishers.Sequence<[String], Never>(sequence: ["1", "2", "3", "4", "5"])
//publisher.subscribe(TestSubscriber())

//let publisher = Future<String, Never> { completion in
//    completion(.success("Future Publisher에서 publish한 값"))
//}
//publisher.subscribe(TestSubscriber())

//let publisher = Empty<String, Never>()
//publisher.subscribe(TestSubscriber())



//let publisher = CurrentValueSubject<String, Never>("CurrentValueSubject에서 Publish한 값")
//publisher.subscribe(TestSubscriber())
//publisher.send("1")
//publisher.send("2")
//
//// 커스텀하지 않고 바로 Subscriber를 만들기
//let subscriber = publisher.sink { value in
//    print("Publisher로부터 받은 값:\(value)")
//}


//let publisher = PassthroughSubject<String, Never>()
//publisher.subscribe(TestSubscriber())

//MARK: MERGE
//let publisher1 = Just("저스트")
//let publisher2 = CurrentValueSubject<String, Never>("CurrentValueSubject에서 Publish한 값")
//let mergedPublishers = Publishers.Merge(publisher1, publisher2)
//mergedPublishers.subscribe(TestSubscriber())

//let publisher1 = CurrentValueSubject<String, Never>("CurrentValueSubject1에서 보내는 1번째 값")
//let publisher2 = CurrentValueSubject<String, Never>("CurrentValueSubject2에서 보내는 1번째 값")
//
//let combinedPublisher = Publishers.CombineLatest(publisher1, publisher2)
//    .map { value1, value2 in
//        return "\(value1) - \(value2)"
//    }
//
//combinedPublisher.subscribe(TestSubscriber())
//publisher1.send("CurrentValueSubject1에서 보내는 2번째 값")
//publisher2.send("CurrentValueSubject2에서 보내는 2번째 값")


//let publisher1 = CurrentValueSubject<String, Never>("CurrentValueSubject1에서 보내는 1번째 값")
//let publisher2 = CurrentValueSubject<String, Never>("CurrentValueSubject2에서 보내는 1번째 값")
//
//let zippedPublisher = Publishers.Zip(publisher1, publisher2)
//    .map { value1, value2 in
//        return "\(value1) - \(value2)"
//    }
//
//zippedPublisher.subscribe(TestSubscriber())
//publisher1.send("CurrentValueSubject1에서 보내는 2번째 값")
//publisher2.send("CurrentValueSubject2에서 보내는 2번째 값")
//publisher1.send("CurrentValueSubject1에서 보내는 3번째 값")
//publisher2.send("CurrentValueSubject2에서 보내는 3번째 값")

//let publisher = CurrentValueSubject<String, Never>("CurrentValueSubject1에서 보내는 1번째 값")
//let subscriber = publisher.sink { value in
//    print("Publisher로부터 받은 값:\(value)")
//}
//publisher.send("CurrentValueSubject1에서 보내는 2번째 값")

//let publisher = CurrentValueSubject<String, Never>("CurrentValueSubject1에서 보내는 1번째 값")
//let subscriber = publisher.sink { value in
//    print(value)
//}
//
//publisher.send("CurrentValueSubject1에서 보내는 2번째 값")
//subscriber.cancel()
//publisher.send("CurrentValueSubject1에서 보내는 3번째 값")


//let just = Just("Hello world!")
//
//let subscriber = just.sink(
//        receiveCompletion: {
//            print("Received completion", $0)
//        },
//        receiveValue: {
//            print("Received value", $0)
//        })
//just.subscribe(TestSubscriber())

//let publisher = CurrentValueSubject<String, Never>("CurrentValueSubject에서 보내는 1번째 값")
//let subscriver = publisher.sink { completion in
//    print(completion)
//} receiveValue: { value in
//    print("Received value: \(value)")
//}
//publisher.subscribe(TestSubscriber())
//publisher.send(completion: .finished)
//publisher.send("hi")

//let passthroughSubject = PassthroughSubject<String, Error>()
//
//let subscriber = passthroughSubject.sink(receiveCompletion: { (result) in
//    switch result {
//    case .finished:
//        print("finished")
//    case .failure(let error):
//        print(error.localizedDescription)
//    }
//}, receiveValue: { (value) in
//    print(value)
//})
//
//passthroughSubject.send("테스트1")
//passthroughSubject.send("테스트2")
//passthroughSubject.send(completion: .finished)
//passthroughSubject.send("완료 후 출력 X")


//let subscriber = publisher.sink { value in
//    print("Publisher로부터 받은 값:\(value)")
//}

let publisher = PassthroughSubject<String, Error>()
var cancellables = Set<AnyCancellable>()
publisher.sink { completion in
    switch completion {
    case .finished:
        print("완료")
        break
    case .failure(let error):
        print("발생한 에러:\(error.localizedDescription)")
    }
} receiveValue: { value in
    print("Publisher로부터 받은 값:\(value)")
}.store(in: &cancellables)
publisher.send(subscription: Subscriptions.empty)
publisher.send("테스트1")
publisher.send(completion: .finished)

for i in cancellables {
    i.cancel()
}

