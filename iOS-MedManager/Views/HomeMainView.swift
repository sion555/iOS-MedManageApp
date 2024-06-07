//
//  HomeMainView.swift
//  iOS-MedManager
//
//  Created by ksy on 6/3/24.
//

import SwiftUI

struct HomeMainView: View {
    
    //Gauge(임시로 임의의 수치를 넣음)
    @State var progress: Double = 0.5
    @State var current: Double = 50.0
    var minValue: Double = 0
    var maxValue: Double = 100
    
    //모달 뷰를 제어하는 상태변수
    @State private var isReceiptViewPresented = false
    
    //현재 날짜를 저장하는 변수
    @State private var currentDate: Date = Date()
    
    //날짜를 문자열로 반환
    private var dateString: String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        return dateFormatter.string(from: currentDate)
    }
    
    //약 추가 버튼 팜업창 변수
    @State private var showingPopup = false
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "bell")
                        .font(.title)
                }.padding(.horizontal)
                
                
                HStack {
                    Image("약톡톡 고양이메인캐릭터")
                        .resizable()
                        .frame(width: 135, height: 140)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading){
                        HStack {
                            VStack(alignment: .leading, spacing: 20) {
                                Text("총 복약 수")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                + Text("12개")
                                    .font(.title2)
                                    .foregroundStyle(.blue)
                                    .bold()
                                
                                Text("사용자님")
                                    .font(.title)
                                    .foregroundStyle(.orange)
                                    .bold()
                            }
                            .padding(.vertical)
                            
                            //하루 복용량 게이지
                            Gauge(value: progress, label: { Text("\(Int(current))%") })
                                .padding()
                                .gaugeStyle(.accessoryCircularCapacity)
                                .foregroundStyle(.blue)
                        }
                        Text("오늘도 좋은 하루 되세요")
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                   
                }.padding(.bottom, 10)
                
                //날짜 버튼 조작 및 날짜확인
                HStack {
                    Button(action: {
                        currentDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate) ?? currentDate
                    }, label: {
                        Image(systemName: "chevron.left.circle")
                    })
                    Spacer()
                    Text(dateString)
                        .font(.title2)
                        .foregroundStyle(.black)
                        .fontWeight(.medium)
                    Spacer()
                    Button(action: {
                        currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate) ?? currentDate
                    }, label: {
                        Image(systemName: "chevron.right.circle")
                    })
                    
                }.padding(.horizontal)
                
                //영수증 내역 확인, 선택 시 영수증 뷰로 모달 뷰가 표시됨
                HStack {
                    Spacer()
                    Text("영수증 확인")
                        .frame(width: 80, height: 5)
                        .padding()
                        .foregroundStyle(.white)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .onTapGesture { isReceiptViewPresented = true }
                        .sheet(isPresented: $isReceiptViewPresented) {
                            PillReceiptView()
                        }.padding(.horizontal)
                }
                
                VStack {
                    Spacer()
                    //약 추가 플로팅 버튼
                    ZStack(alignment: .bottomTrailing) {
                        HomeRowView()
                        
                        Button(action: {
                            withAnimation {
                                showingPopup.toggle()
                            }
                        }) {
                            HStack {
                                Image(systemName: showingPopup ? "xmark.circle.fill" : "pills")
                                    .font(.title)
                                Text(showingPopup ? "취소" : "약 추가")
                                    .font(.title3)
    
                            }
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }.padding()
                        //플로딩 버튼 원 모양으로 구현
//                        Button(action: {
//                            showingPopup.toggle()
//                            }, label: {
//                                //원형으로 만들어 봄
//                                Image(systemName: "plus")
//                                    .foregroundStyle(.white)
//                                    .frame(width: 60, height: 60)
//                                    .background(Color.blue)
//                                    .clipShape(Circle())
//                                    .shadow(radius: 4, x: 0, y: 4)
//                            }).padding()
                            
                        //플로팅 버튼 선택 시 팜업 창 구현
                            if showingPopup {
                                VStack {
                                    VStack(spacing: 20) {
                                        Button(action: {
                                            showingPopup = false
                                        }) {
                                            HStack {
                                                Image(systemName: "plus.square")
                                                Text("약 봉투 촬영")
                                            }
                                        }
                                        //팜업 버튼 사이 구분선 추가
                                        Divider()
                                            .frame(width: 100)
                                        Button(action: {
                                            showingPopup = false
                                        }) {
                                            //네이게이션링크 연결 PillAddView로 이동
                                            NavigationLink(destination: PillAddView()) {
                                                    HStack {
                                                        Image(systemName: "pencil")
                                                        Text("직접 입력")
                                                    }
                                                }
                                        }
                                    }
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 10)
                                    .padding()
                                    Spacer()
                                }
                                //팜업 창 위치 조정 및 취소 버튼 선택 시 팜업창이 사라짐
                                .padding(.top, 250)
                                .background(Color.clear)
                                .onTapGesture {
                                    withAnimation {
                                        showingPopup = false
                                    }
                                }
                            }
                    }
                }
            }
        }
    }

}
                           

#Preview {
    HomeMainView()
}
