//
//  CalenderView.swift
//  iOS-MedManager
//
//  Created by ksy on 6/3/24.
//


import SwiftUI

struct CalenderView: View {
    @State var currentDate: Date = Date()
    var body: some View {
        ScrollView (.vertical, showsIndicators: false){
            VStack(spacing: 20) {
                CustomCalenderView(currentDate : $currentDate)
            }
        }
    }
}

#Preview {
    CalenderView()
}
