//
//  NotificationTestView.swift
//  Notification_SwiftUI
//
//  Created by 이유경 on 6/9/24.
//

import SwiftUI
import UserNotifications


struct NotificationTestView: View {
    var body: some View {
        VStack {
            Button("Request Notification Permission") { // 로그인 후 메인뷰에서 이 코드 실행
                NotificationManager.instance.requestAuthorization()
            }
//            Button("Schedule Notification") { // 알람 시간을 설정했을 때
//                NotificationManager.instance.scheduleNotification()
//            }
            Button("Cancel Notifications") { // 토글로 껐을 때
                NotificationManager.instance.cancelNotifications()
            }
            Button("Reset Badge Number") { // 앱에 들어왔을 때
                NotificationManager.instance.deleteBadgeNumber()
            }
        }
    }
}

#Preview {
    NotificationTestView()
}
