//
//  PillAddView.swift
//  iOS-MedManager
//
//  Created by ksy on 6/5/24.
//

import SwiftUI

struct PillAddView: View {
    let pillNumSelect = ["1정씩", "2정씩", "3정씩", "4정씩", "5정씩", "6정씩", "7정씩", "8정씩", "9정씩", "10정씩"]
    @State private var selectedNum = ""
    
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
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("복약 기간과 시간을")
                Text("설정해주세요")
            }
            .font(.title)
            .padding()
            
            Divider()
                .frame(height: 5)
                .background(Color.secondary)
            
            HStack {
                Text("복약 기간 설정")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.secondary)
                    .padding(.trailing)
                Spacer()
                
                VStack {
                    HStack {
                        Button(action: { isStartDatePicker.toggle()}) {
                            Text("시작 날짜")
                        }
                        if isStartDatePicker {
                            DatePicker("", selection: $startDate, displayedComponents: .date)
                                .datePickerStyle(.automatic)
                                .padding()
                        }
                    }
                    
                    HStack {
                        Button(action: { isEndDatePicker.toggle()}) {
                            Text("종료 날짜")
                        }
                        if isEndDatePicker {
                            DatePicker("", selection: $endDate,
                                       displayedComponents: .date)
                            .datePickerStyle(.automatic)
                        }
                    }
                }
            }
            .padding()
            .padding(.horizontal, 30)
            
            Divider()
                .frame(height: 5)
                .background(Color.secondary)
            List {
                Section {
                    Text("추가된 약")
                        .font(.title3)
                        .fontWeight(.medium)
                        .listRowSeparator(.hidden)
                    
                    HStack(alignment: .top) {
                        Image("약톡톡 고양이메인캐릭터")
                            .resizable()
                            .frame(width: 80, height: 30)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        VStack(alignment: .leading) {
                            Text("크래빅스정")
                                .fontWeight(.semibold)
                            
                            Text("[마크로라이트계 항생제]")
                                .foregroundStyle(.secondary)
                                .lineLimit(1)
                                .fixedSize(horizontal: true, vertical: false)
                            
                            HStack {
                                Button(action: {}, label: {
                                    Text("아침")
                                        .font(.footnote)
                                        .frame(width: 40, height: 20)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 30)
                                                .stroke(Color.blue, lineWidth: 2)
                                        )
                                })
                                Button(action: {}, label: {
                                    Text("점심")
                                        .font(.footnote)
                                        .frame(width: 40, height: 20)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 30)
                                                .stroke(Color.blue, lineWidth: 2)
                                        )
                                })
                                Button(action: {}, label: {
                                    Text("저녁")
                                        .font(.footnote)
                                        .frame(width: 40, height: 20)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 30)
                                                .stroke(Color.blue, lineWidth: 2)
                                        )
                                })
                            }
                        }
                        
                        //picker
                        Picker("", selection: $selectedNum) {
                            ForEach(pillNumSelect, id: \.self) {
                                Text($0)
                                    .font(.subheadline)
                                    .foregroundStyle(.primary)
                            }
                        }
                        .pickerStyle(.automatic)
                    }
                }.listRowSeparator(.hidden)
                
            }
            .listStyle(PlainListStyle())
            
            HStack {
                Button(action: {}, label: {
                    Text("취소")
                        .font(.title2)
                        .frame(width: 80)
                        .padding()
                        .foregroundStyle(.white)
                        .background(.gray)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                })
                .padding()
                Button(action: {}, label: {
                    Text("추가하기")
                        .font(.title2)
                        .frame(width: 150)
                        .padding()
                        .foregroundStyle(.white)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                })
                
            }
            .padding()
        }
        .navigationTitle("약 추가")
        .navigationBarItems(trailing: Image(systemName: "plus"))
        
    }
}
   

#Preview {
    PillAddView(dateInterval: .constant(DateInterval(start: Date().startOfMonth(), end: Date().endOfMonth())))
}
