//
//  MainView.swift
//  iOS-MedManager
//
//  Created by ksy on 6/3/24.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        TabView {
            HomeMainView()
                .tabItem {
                    Image(systemName: "house")
                    Text("홈화면")
                }
            CalenderView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("캘린더")
                }
            UserInfoView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("설정")
                }
        }
    }
}

#Preview {
    MainView()
}
