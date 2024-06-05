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
                    Text("일정관리")
                }
            UserInfoView()
                .tabItem {
                    Image(systemName: "person")
                    Text("내 정보")
                }
        }
    }
}

#Preview {
    MainView()
}
