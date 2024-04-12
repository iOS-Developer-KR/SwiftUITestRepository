//
//  ContentView.swift
//  LongPressGestureExample
//
//  Created by Taewon Yoon on 4/11/24.
//

import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager {
    
    static let instance = NotificationManager() // 싱글톤: 어디서든 사용할 수 있는 유일한 인스턴스
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error = error {
                print("ERROR: \(error)")
            } else {
                print("SUCCESS")
            }
        }
    }
    
    func scheduleNotification() {
        
        let content = UNMutableNotificationContent() //
        content.title = "첫 알람"
        content.subtitle = "서브 타이틀"
        content.sound = .default
        content.badge = 1
        
        // time
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        // calendar
//        var dateComponents = DateComponents() // 매일 설정한 시간에 알림
//        dateComponents.hour = 19
//        dateComponents.minute = 16
//        dateComponents.weekday = 2
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        // location
        let coordinates = CLLocationCoordinate2D(latitude: 40.00, longitude: 50.00)
        
        let region = CLCircularRegion(center: coordinates, radius: 100, identifier: UUID().uuidString)
        
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        region.notifyOnEntry = true // radius 반경 안에 들어갔을 때 트리거 작동 여부
        region.notifyOnExit = false // radius 반경 밖으로 나갔을 때 트리가 작동 여부
        
        let requeset = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)
        
        UNUserNotificationCenter.current().add(requeset)
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
}


struct ContentView: View {
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        VStack(spacing: 40) {
            Button("권한 받기") {
                NotificationManager.instance.requestAuthorization()
            }
            Button("알람 설정") {
                NotificationManager.instance.scheduleNotification()
            }
            Button("알림 취소") {
                NotificationManager.instance.cancelNotification()
            }
        }
        .onChange(of: scenePhase, { oldValue, newValue in
            if newValue == .active {
                UNUserNotificationCenter.current().setBadgeCount(0) { error in
                    if let error = error {
                        print("에러발생:\(error)")
                    }
                }
            }
        })
    }
}

#Preview {
    ContentView()
}
