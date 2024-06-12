//
//  PillAddRowView.swift
//  iOS-MedManager
//
//  Created by ksy on 6/10/24.
//

import SwiftUI

struct PillAddRowView: View {
    // 알약 수량
    let pillNumSelect = ["0.5정", "1정", "1.5정", "2정", "2.5정", "3정", "3.5정", "4정", "4.5정", "5정"]
    @State private var selectedNum = "1정"
    // 아침, 점심, 저녁 약 복용 시간 버튼 선택
    @State private var isMorningDoseTime = false
    @State private var isAfternoonDoseTime = false
    @State private var isEveningDoseTime = false
    
    var body: some View {
        List {
            Section {
                Text("추가된 약")
                    .font(.title3)
                    .fontWeight(.medium)
                    .listRowSeparator(.hidden)
                    
                HStack(alignment: .top) {
                    //생성된 row의 삭제 기능 추가 필요
                    Image("샘플약이미지")
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
                        
                        // 알약 복용 시간 버튼
                        HStack {
                            Button(action: {
                                isMorningDoseTime.toggle()
                            }) {
                                Text("아침")
                            }
                            .buttonStyle(DoseTimeButtonStyle(isSelected: isMorningDoseTime))
                        
                            Button(action: {
                                isAfternoonDoseTime.toggle()
                            }) {
                                Text("점심")
                            }
                            .buttonStyle(DoseTimeButtonStyle(isSelected: isAfternoonDoseTime))
                            
                            Button(action: {
                                isEveningDoseTime.toggle()
                            }) {
                                Text("저녁")
                            }
                            .buttonStyle(DoseTimeButtonStyle(isSelected: isEveningDoseTime))
                        }
                    }
                    // picker
                    Picker("", selection: $selectedNum) {
                        ForEach(pillNumSelect, id: \.self) {
                            Text($0)
                                .font(.subheadline)
                                .foregroundStyle(.primary)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
            }.listRowSeparator(.hidden)
        }
        .listStyle(PlainListStyle())
    }
}

//ButtonStyle 프로토콜을 이용해서 버튼의 색 변화를 지정함
struct DoseTimeButtonStyle: ButtonStyle {
    var isSelected: Bool
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.footnote)
            .frame(width: 55, height: 25)
            .foregroundColor(isSelected ? .white : .black)
            .background(isSelected ? .blue : .white)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.blue, lineWidth: 2)
            )
            // 버튼이 눌릴 때 크기 변화
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

#Preview {
    PillAddRowView()
}
