//
//  ContentView.swift
//  iOS-MedManager
//
//  Created by 한범석 on 6/3/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn = true
    @State var isPresented: Bool = false
    @State private var image: UIImage?
    
    var body: some View {
        NavigationStack {
            if isLoggedIn {
                TabView {
                    HomeMainView()
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("홈")
                        }                   
                }
            } else {
                LoginView(isLoggedIn: $isLoggedIn)
            }
        }
    }
}

//#Preview {
//    ContentView(image: .constant())
//}
