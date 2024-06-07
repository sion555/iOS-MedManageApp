//
//  UserInfoView.swift
//  iOS-MedManager
//
//  Created by ksy on 6/5/24.
//

import SwiftUI

struct UserInfoView: View {
    @State var isExpanded1 = true
    @State var isExpanded2 = true
    @State var isExpanded3 = true
    @State var isExpanded4 = true
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("약톡톡 고양이메인캐릭터")
                    .resizable()
                    .frame(width: 80, height: 80)
                VStack(alignment: .leading) {
                    Text("사용자님")
                        .font(.title)
                        .foregroundStyle(.orange)
                    Text("안녕하세요!")
                        .font(.title)
                }
            }.padding()
            
            List {
                Section(isExpanded: $isExpanded1){
                    Text("병원 기록")
                    Text("특이사항")
                } header: {
                    Text("내 정보")
                        .font(.title)
                }
                Section(isExpanded: $isExpanded2){
                    Text("알림")
                } header: {
                    Text("앱 설정")
                        .font(.title)
                }
                
                Section(isExpanded: $isExpanded3){
                    Text("로그아웃")
                    Text("회원 탈퇴")
                } header: {
                    Text("계정 설정")
                        .font(.title)
                }
                
                Section(isExpanded: $isExpanded4){
                    Text("오픈소스 라이선스")
                    Text("이용약관")
                    Text("개인정보처리방침")
                } header: {
                    Text("약관 및 정책")
                        .font(.title)
                }
            }.listStyle(.sidebar)
            
        }
    }
}

#Preview {
    UserInfoView()
}
