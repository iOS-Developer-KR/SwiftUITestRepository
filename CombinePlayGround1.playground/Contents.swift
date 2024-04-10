import UIKit
import Combine
 // [Int] = output, Never = Error
var myIntArrayPublisher: Publishers.Sequence<[Int], Never> = [1,2,3].publisher // Int 배열이 나가고, Never는

myIntArrayPublisher.sink { completion in
    switch completion {
    case .finished:
        print("완료")
    case .failure(let error): // Never로 설정하면 에러가 들어와도 내보내지 않는다
        print("실패 : error : \(error)")
    }
} receiveValue: { receivedValue in
    print("값을 받았다. : \(receivedValue)")
}

var myNotification = Notification.Name("hello")

var mySubscriptionSet = Set<AnyCancellable>()

var myDefaultPublisher: NotificationCenter.Publisher = NotificationCenter.default.publisher(for: myNotification)

var mySubscription: AnyCancellable?

mySubscription = myDefaultPublisher.sink(receiveCompletion: { completion in
    switch completion {
    case .finished:
        print("완료")
    case .failure(let error):
        print("에러: \(error)")
    }
}, receiveValue: { value in
    print(value)
})


mySubscription?.store(in: &mySubscriptionSet) // $는 in,out이다 매개변수를 변경할 수 있게 해준다
NotificationCenter.default.post(Notification(name: myNotification))
NotificationCenter.default.post(Notification(name: myNotification))
NotificationCenter.default.post(Notification(name: myNotification))

mySubscription?.cancel() // 메모리에서 날리기

//KVO - Key value observing

class MyFriend {
    var name = "철수" {
        didSet{
            print("name - didSet() : ", name)
        }
    }
}

var myFriend = MyFriend()
// 철수 -> 영수
var myFriendSubscription: AnyCancellable = ["영수"].publisher.assign(to: \.name, on: myFriend)
