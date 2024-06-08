//
//  UserInfoView.swift
//  iOS-MedManager
//
//  Created by ksy on 6/5/24.
//

import SwiftUI

struct UserInfoView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                
                Spacer()
                VStack(alignment: .center) {
                    Image("약톡톡 고양이메인캐릭터")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                    
                    Text("사용자님")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.orange)
                    
                    Button(action: {}, label: {
                        Text("내 정보 수정")
                            .frame(width: 100, height: 30)
                        // 버튼 테두리 색과 두께 설정
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.blue, lineWidth: 2)
                            )
                    })
                    .padding(.bottom, 10)
                    
                    HStack(spacing: 20) {
                        Button(action: {}, label: {
                            Text("알림")
                        }).padding()
                        Divider()
                            .frame(width: 2 , height: 30)
                            .background(.white)
                            
                        Button(action: {}, label: {
                            Text("특이사항")
                        })
                        Divider()
                            .frame(width: 2 ,height: 30)
                            .background(.white)
                        Button(action: {}, label: {
                            Text("문의")
                        }).padding()
                    }
                    .frame(width: 300, height: 50)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    
                }
                .padding()
                .frame(maxWidth: .infinity)
                
                List {
                    
                    Section {
                        Text("로그아웃")
                        Text("회원 탈퇴")
                    }
                    
                    Section {
                        Text("오픈소스 라이선스")
                        Text("이용약관")
                        Text("개인정보처리방침")
                    
                    }
                }.listStyle(.sidebar)
                
            }
        }
        .navigationTitle("설정")
    }
}

#Preview {
    UserInfoView()
}
