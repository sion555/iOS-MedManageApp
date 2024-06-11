//
//  PopupView.swift
//  iOS-MedManager
//
//  Created by 한범석 on 6/10/24.
//

import SwiftUI

struct PopupView: View {
    @Binding var showPopup: Bool
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Button(action: {
                    // 약 봉투 촬영 액션
                }) {
                    HStack {
                        Image(systemName: "camera")
                        Text("약 봉투 촬영")
                    }
                }
                .padding()
                
                Button(action: {
                    // 직접 입력 액션
                }) {
                    HStack {
                        Image(systemName: "pencil")
                        Text("직접 입력")
                    }
                }
                .padding()
            }
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding()
            .background(Color.clear)
        }
    }
}

#Preview {
    PopupView(showPopup: .constant(true))
}
