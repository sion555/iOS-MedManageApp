//
//  Notification.swift
//  Notification_SwiftUI
//
//  Created by 이유경 on 6/9/24.
//

import Foundation
import UserNotifications

class NotificationManager: ObservableObject {
    static let instance = NotificationManager()  // Singleton
    
    @Published var toggleSwitch: Bool = false
    @Published var morning: Date = Date()
    @Published var noon: Date = Date()
    @Published var evening: Date = Date()
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("ERROR: \(error)")
            } else {
                print("SUCCESS")
            }
        }
    }
    
    func scheduleNotifications() {
        if toggleSwitch {
            scheduleNotification(time: morning, identifier: "MorningNotification")
            scheduleNotification(time: noon, identifier: "NoonNotification")
            scheduleNotification(time: evening, identifier: "EveningNotification")
        }
    }
    
    func scheduleNotification(time: Date, identifier: String) {
        let content = UNMutableNotificationContent()
        content.title = "약톡톡에서 알림"
        content.subtitle = "약 드실 시간이에요!"
        content.sound = .default
        content.badge = 0 // badge 설정 안 함
        
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: time)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
    
    func cancelNotifications() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["MorningNotification", "NoonNotification", "EveningNotification"])
        print("cancelNotifications")
    }
    
    func deleteBadgeNumber() {
        UNUserNotificationCenter.current().setBadgeCount(0)
        print("deleteBadgeNumber")
    }
}
