//
//  ContentView.swift
//  iOS-MedManager
//
//  Created by 한범석 on 6/3/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn = false
    
    var body: some View {
        NavigationStack {
            if isLoggedIn {
                HomeMainView()
            } else {
                LoginView(isLoggedIn: $isLoggedIn)
            }
        }
    }
}

#Preview {
    ContentView()
}
