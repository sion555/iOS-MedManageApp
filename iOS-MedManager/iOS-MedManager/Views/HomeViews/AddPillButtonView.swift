//
//  AddPillButtonView.swift
//  iOS-MedManager
//
//  Created by 한범석 on 6/10/24.
//

import SwiftUI

struct AddPillButtonView: View {
    @Binding var showingPopup: Bool
    @Binding var navigateToSearchView: Bool

    var body: some View {
        VStack {
            Button(action: {
                withAnimation {
                    showingPopup.toggle()
                }
            }) {
                HStack {
                    Image(systemName: showingPopup ? "xmark.circle.fill" : "plus.circle.fill")
                        .font(.title)
                    Text(showingPopup ? "취소" : "약 추가")
                        .font(.title3)
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding(.bottom, 20)

            if showingPopup {
                VStack {
                    Button(action: {
                        showingPopup = false
                    }) {
                        HStack {
                            Image(systemName: "plus.square")
                            Text("약 봉투")
                        }
                    }
                    
                    Button(action: {
                        navigateToSearchView = true
                        showingPopup = false
                    }) {
                        HStack {
                            Image(systemName: "pencil")
                            Text("직접 입력")
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)
                .padding()
            }
        }
    }
}


#Preview {
    AddPillButtonView(showingPopup: .constant(false), navigateToSearchView: .constant(false))
}
