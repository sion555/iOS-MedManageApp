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
            ZStack {
                Color(UIColor.systemGroupedBackground) // 배경색 설정
                    .edgesIgnoringSafeArea(.all) // 모든 가장자리를 무시하고 배경색을 확장
                
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
                                .font(.footnote)
                                .frame(width: 100, height: 30)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                            //버튼의 테두리 선 추가
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
                                .frame(width: 2, height: 30)
                                .background(.white)
                                
                            Button(action: {}, label: {
                                Text("특이사항")
                            })
                            Divider()
                                .frame(width: 2, height: 30)
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
                            Text("계정설정")
                                .font(.headline)
                                .foregroundStyle(.secondary)
                                .listRowSeparator(.hidden) // 구분선 숨기기
                                .fontWeight(.semibold)
                            HStack {
                                Text("로그아웃")
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.secondary)
                            }
                            HStack {
                                Text("회원탈퇴")
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.secondary)
                                    .listRowSeparator(.hidden) // 구분선 숨기기
                            }
                        }
                        
                        Section {
                            Text("약관 및 정책")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.secondary)
                                .listRowSeparator(.hidden) // 구분선 숨기기
                            HStack {
                                Text("오픈소스 라이선스")
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.secondary)
                            }
                            HStack {
                                Text("이용약관")
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.secondary)
                            }
                            HStack {
                                Text("개인정보처리방침")
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                    .background(Color(UIColor.systemGroupedBackground)) // List의 배경색 설정
                }
            }
        }
        .navigationTitle("설정")
    }
}

#Preview {
    UserInfoView()
}
