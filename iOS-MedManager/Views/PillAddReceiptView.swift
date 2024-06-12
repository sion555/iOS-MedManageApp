//
//  PillAddReceiptView.swift
//  iOS-MedManager
//
//  Created by ksy on 6/11/24.
//

import SwiftUI

struct PillAddReceiptView: View {
    @State var hospitalName = "" //병원이름
    @State var pharmacyName = "" //약국이름
    @State var receiptNum = "" //영수증번호
    @State private var selectedPay = "" //결제방법
    @State var personalExpense = 0 //개인부담금
    @State var insuranceExpense = 0 //보험자부담금
    @State var nonExpense = 0 //비급여
    @State var totalAmount = 0 //총수납금액
    
    //picker
    let payment = ["카드결제", "현금결제"]

    // numberFormatter 변수 정의 및 초기화
    let numberFormatter: NumberFormatter = {
        // NumberFormatter 인스턴스 생성
        let numberFormatter = NumberFormatter()
        
        // 숫자 스타일을 소수점 없는 10진수로 설정
        numberFormatter.numberStyle = .decimal
        
        // 최대 소수 자릿수를 0으로 설정하여 소수점 이하를 표시하지 않음
        numberFormatter.maximumFractionDigits = 0
        
        // 초기화된 NumberFormatter 인스턴스를 반환
        return numberFormatter
    }()

    
    var body: some View {
        NavigationStack {
            List {
                VStack {
                    TextField("병원이름을 입력하세요", text: $hospitalName)
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .bold()
                        .foregroundStyle(.blue)
                        .padding()
                    
                    HStack {
                        Text("약국 이름")
                            .foregroundStyle(.secondary)
                            .bold()
                        Spacer()
                        TextField("약국이름", text: $pharmacyName)
                            .multilineTextAlignment(.trailing)
                            
                    }.padding()
                    
                    HStack {
                        Text("영수증번호")
                            .foregroundStyle(.secondary)
                            .bold()
                        Spacer()
                        TextField("영수증번호", text: $receiptNum)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                    }.padding()
                    
                    HStack {
                        Text("결제방법")
                            .foregroundStyle(.secondary)
                            .bold()
                        Spacer()
                        Picker("", selection: $selectedPay) {
                            ForEach(payment, id: \.self) {
                                Text($0)
                                    .font(.subheadline)
                                    .foregroundStyle(.primary)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }.padding()
                    
                    HStack {
                        Text("본인부담금")
                            .foregroundStyle(.secondary)
                            .bold()
                        Spacer()
                        TextField("", value: $personalExpense, formatter: numberFormatter)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                            .foregroundColor(personalExpense != 0 ? .primary : .gray)
                        if personalExpense != 0 {
                                Text("원")
                        } else {
                            Text("원")
                                .foregroundStyle(.secondary)
                        }
                    }.padding()
                    
                    HStack {
                        Text("보험자부담금")
                            .foregroundStyle(.secondary)
                            .bold()
                        Spacer()
                        TextField("", value: $insuranceExpense, formatter: numberFormatter)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                            .foregroundColor(insuranceExpense != 0 ? .primary : .gray)
                        if insuranceExpense != 0 {
                            Text("원")
                        } else {
                            Text("원")
                                .foregroundStyle(.secondary)
                        }
                    }.padding()
                    
                    HStack {
                        Text("비급여")
                            .foregroundStyle(.secondary)
                            .bold()
                        Spacer()
                        TextField("", value: $nonExpense, formatter: numberFormatter)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                            .foregroundColor(nonExpense != 0 ? .primary : .gray)
                        if nonExpense != 0 {
                            Text("원")
                        } else {
                            Text("원")
                                .foregroundStyle(.secondary)
                        }
                    }.padding()
                    
                    Divider()
                    HStack {
                        Text("총 수납금액")
                            .foregroundStyle(.selection)
                            .bold()
                        Spacer()
                        // 본인부담금과 비급여의 합계를 계산하여 표시
                        Text("\(personalExpense + nonExpense)원")
                            .font(.title2)
                            .foregroundColor((personalExpense + nonExpense) != 0 ? .primary : .secondary)
                    }
                    .font(.title2)
                    .padding()
                    
                }
                HStack {
                    Button(action: {
                        
                    }, label: {
                        Text("취소")
                            .font(.title2)
                            .bold()
                            .frame(width: 80)
                            .padding()
                            .foregroundStyle(.white)
                            .background(.separator)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    })
                    Spacer()
                    Button(action: {
                        
                    }, label: {
                        Text("추가하기")
                            .font(.title2)
                            .bold()
                            .frame(width: 150)
                            .padding()
                            .foregroundStyle(.white)
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    })
                }.padding()
            }
        }
        .navigationTitle("영수증 추가")
    }
}

#Preview {
    PillAddReceiptView()
}
