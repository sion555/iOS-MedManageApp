//
//  ContentView.swift
//  NotificationCenter_SwiftUI
//
//  Created by wizard on 6/6/24.
//

import SwiftUI

//            .onAppear { 로그인 후 메인뷰에서 띄움
//                        NotificationManager.instance.requestAuthorization()
//                        setNotifications()
//                    }

struct ContentView: View {
    
    var body: some View {
       AlarmView()
    }
}


#Preview {
    ContentView()
}
