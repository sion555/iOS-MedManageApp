//
//  PillAddView.swift
//  iOS-MedManager
//
//  Created by ksy on 6/5/24.
//

import SwiftUI

struct PillAddView: View {
    
    //DateInterval
    //양 방향 바인딩을 위한 DateInterval객체 바인딩
    @Binding var dateInterval: DateInterval
    //시작날짜와 끝날짜를 선택하는 State 속성
    @State private var startDate = Date().startOfMonth()
    @State private var isStartDatePicker = false
    @State private var endDate = Date().endOfMonth()
    @State private var isEndDatePicker = false
    // 선택한 시작 및 종료 날짜로 dateInterval을 업데이트하는 함수입니다.
    func updateDateInterval() {
        dateInterval = DateInterval(start: startDate, end: endDate)
    }
    //추가하기 버튼을 통해 영수증 추가 뷰와 연결
    @State var addReceipt = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Spacer()
                Text("복약 기간과 시간을")
                    .font(.title)
                    .padding(.horizontal, 30)
                Text("설정해주세요")
                    .font(.title)
                    .padding(.horizontal, 30)
                    .padding(.bottom, 20)
                
                Divider()
                    .frame(height: 5)
                    .background(Color.secondary)
                
                
                    HStack {
                        Text("복약 기간 설정")
                            .font(.title2)
                            .bold()
                            .foregroundStyle(.secondary)
                            
                        Spacer()
                        
                        // 복용 기간 설정
                    VStack {
                        HStack {
                            Button(action: {
                                isStartDatePicker.toggle()
                            }) {
                                Text("시작 날짜")
                            }
                            if isStartDatePicker {
                                DatePicker("", selection: $startDate,
                                           displayedComponents: .date)
                                .datePickerStyle(.compact)
                            }
                        }.frame(width: 110)
                        
                        HStack {
                            Button(action: {
                                isEndDatePicker.toggle()
                            }) {
                                Text("종료 날짜")
                            }
                            if isEndDatePicker {
                                DatePicker("", selection: $endDate,
                                           displayedComponents: .date)
                                .datePickerStyle(.compact)
                                
                            }
                        }.frame(width: 100)
                    }
                }
                .padding()
                .padding(.horizontal, 30)

                
                Divider()
                    .frame(height: 5)
                    .background(Color.secondary)
                
                //약 추가 Row 가져옴
                PillAddRowView()
                
                
                HStack {
                    Button(action: {
                        
                    }, label: {
                        Text("취소")
                            .font(.title2)
                            .bold()
                            .frame(width: 90)
                            .padding()
                            .foregroundStyle(.white)
                            .background(.separator)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    })
                    .padding()
                    NavigationLink {
                        PillAddReceiptView()
                    } label: {
                        Text("추가하기")
                              .font(.title2)
                              .bold()
                              .frame(width: 150)
                              .padding()
                              .foregroundStyle(.white)
                              .background(.blue)
                              .clipShape(RoundedRectangle(cornerRadius: 10))
                    }

                }
                .padding()
            }
        }
        .navigationBarItems(trailing: Image(systemName: "plus")
            .foregroundStyle(.blue))
        .navigationTitle("약 추가")
        .toolbarBackground(Color.gray, for: .navigationBar)
    }
}
   

#Preview {
    PillAddView(dateInterval: .constant(DateInterval(start: Date().startOfMonth(), end: Date().endOfMonth())))
}
