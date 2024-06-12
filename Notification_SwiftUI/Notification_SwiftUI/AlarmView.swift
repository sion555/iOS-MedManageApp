//
//  AlarmView.swift
//  Notification_SwiftUI
//
//  Created by 이유경 on 6/9/24.
//

import SwiftUI

struct AlarmView: View {
    @ObservedObject var notificationManager = NotificationManager.instance
    
    var body: some View {
        Form {
            Section {
                Toggle("알림", isOn: $notificationManager.toggleSwitch)
            } header: {
                Text("알림")
                    .font(.title3)
                    .bold()
            }
            Section {
                DatePicker(selection: $notificationManager.morning, displayedComponents: [.hourAndMinute]) {
                    Label("아침", systemImage: "sun.min.fill")
                }
                DatePicker(selection: $notificationManager.noon, displayedComponents: [.hourAndMinute]) {
                    Label("점심", systemImage: "sun.and.horizon")
                }
                DatePicker(selection: $notificationManager.evening, displayedComponents: [.hourAndMinute]) {
                    Label("저녁", systemImage: "moon.fill")
                }
            } header: {
                Text("시간대 설정")
                    .font(.title3)
                    .bold()
            }
        }
        .onChange(of: notificationManager.toggleSwitch) {
            if notificationManager.toggleSwitch {
                notificationManager.scheduleNotifications()
            } else {
                notificationManager.cancelNotifications()
            }
        }
        .onChange(of: notificationManager.morning) {
            notificationManager.scheduleNotifications()
        }
        .onChange(of: notificationManager.noon) {
            notificationManager.scheduleNotifications()
        }
        .onChange(of: notificationManager.evening) {
            notificationManager.scheduleNotifications()
        }
    }
}


#Preview {
    AlarmView()
}
