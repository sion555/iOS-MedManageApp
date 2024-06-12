//
//  HomeRowView.swift
//  iOS-MedManager
//
//  Created by ksy on 6/3/24.
//

import SwiftUI

struct HomeRowView: View {
    @State private var isExpandedMorning = true // 아침 섹션의 확장/축소 상태
    @State private var isExpandedAfternoon = true // 점심 섹션의 확장/축소 상태
    @State private var isExpandedEvening = true // 저녁 섹션의 확장/축소 상태
    @State private var isCheckedMorning = false // 아침 체크 버튼의 상태
    @State private var isCheckedAfternoon = false // 점심 체크 버튼의 상태
    @State private var isCheckedEvening = false // 저녁 체크 버튼의 상태
    var body: some View {
        
         List {
             //아침 복용약 알림
             Section(isExpanded: $isExpandedMorning){
                 HStack {
                         Image(systemName: "pills")
                             .foregroundStyle(.gray)
                         Text("감기약")
                             .font(.headline)
                         Spacer()
                     HStack {
                         //복용 표시 이미지 선택시 글자 표시
                          if isCheckedMorning {
                              Text("복용완료")
                                  .foregroundColor(.blue)
                          }
                          Button(action: {
                              isCheckedMorning.toggle() // 버튼 상태 토글
                          }, label: {
                              Image(systemName: "checkmark.circle")
                                  .frame(height: 20)
                                  .foregroundStyle(isCheckedMorning ? .blue : .gray) // 상태에 따라 색상 변경
                          })
                      }
                 }
                 .padding()
                 .cornerRadius(10)
             } header: {
                 Text("아침")
                     .font(.title)
                     .fontWeight(.bold)
                     .foregroundStyle(.blue)
             }
             
             
             //점심 복용약 알림
             Section(isExpanded: $isExpandedAfternoon){
                 HStack {
                         Image(systemName: "pills")
                             .foregroundStyle(.gray)
                         Text("감기약")
                             .font(.headline)
                         Spacer()
                    HStack {
                         if isCheckedAfternoon {
                             Text("복용완료")
                                 .foregroundColor(.blue)
                         }//복용 표시 이미지 선택시 글자 표시
                         Button(action: {
                             isCheckedAfternoon.toggle() // 버튼 상태 토글
                         }, label: {
                             Image(systemName: "checkmark.circle")
                                 .frame(height: 20)
                                 .foregroundStyle(isCheckedAfternoon ? .blue : .gray) // 상태에 따라 색상 변경
                         })
                     }
                 }
                 .padding()
                 .cornerRadius(10)
             } header: {
                 Text("점심")
                     .font(.title)
                     .fontWeight(.bold)
                     .foregroundStyle(.blue)
             }
             
             Section(isExpanded: $isExpandedEvening){
                 VStack {
                     
                     HStack {
                             Image(systemName: "pills")
                                 .foregroundStyle(.gray)
                             Text("감기약")
                                 .font(.headline)
                             Spacer()
                        HStack {
                             if isCheckedEvening {
                                 Text("복용완료")
                                     .foregroundColor(.blue)
                             }//복용 표시 이미지 선택시 글자 표시
                             Button(action: {
                                 isCheckedEvening.toggle() // 버튼 상태 토글
                             }, label: {
                                 Image(systemName: "checkmark.circle")
                                     .frame(height: 20)
                                     .foregroundStyle(isCheckedEvening ? .blue : .gray) // 상태에 따라 색상 변경
                             })
                         }
                     }
                     .padding()
                 .cornerRadius(10)
                 }
                 
             } header: {
                 Text("저녁")
                     .font(.title)
                     .fontWeight(.bold)
                     .foregroundStyle(.blue)
             }
              
         }.listStyle(.sidebar)
        //아래 코드를 실행할 경우 row는 모두 잘 보이나 아래에 생성된 padding만큼 화면이 가려져서 섹션 공간이 줄어드는 문제가 발생 다른 방법이 필요
         //.padding(.bottom, 80)
         //.background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.bottom))
    }
}

#Preview {
    HomeRowView()
}
