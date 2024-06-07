//
//  PillReceiptView.swift
//  iOS-MedManager
//
//  Created by ksy on 6/5/24.
//

import SwiftUI

struct Receipt {
    var hospitalName : String = "" //병원이름
    var personalExpense : Int = 0 //개인부담금
    var insuranceExpense : Int = 0 //보험자부담금
    var totalAmount : Int = 0 //총수납금액
}

struct PillReceiptView: View {
    
    let samplerReceiptData = Receipt(hospitalName: "좋은병원", personalExpense: 3000, insuranceExpense: 8000, totalAmount: 3000)
    
    var body: some View {
        List {
            VStack {
            Spacer()
                Text(samplerReceiptData.hospitalName)
                    .font(.title)
                    .bold()
                    .foregroundStyle(.blue)
                    .padding()
                
                HStack {
                    Text("약국 이름")
                        .foregroundStyle(.secondary)
                        .bold()
                    Spacer()
                    Text("조은약국")
                }.padding()
                
                HStack {
                    Text("영수증번호")
                        .foregroundStyle(.secondary)
                        .bold()
                    Spacer()
                    Text("20240607")
                }.padding()
                
                HStack {
                    Text("결제방법")
                        .foregroundStyle(.secondary)
                        .bold()
                    Spacer()
                    Text("카드결제")
                }.padding()
                
                HStack {
                    Text("본인부담금")
                        .foregroundStyle(.secondary)
                        .bold()
                    Spacer()
                    Text("\(samplerReceiptData.personalExpense)원")
                    
                }.padding()
                HStack {
                    Text("보험자부담금")
                        .foregroundStyle(.secondary)
                        .bold()
                    Spacer()
                    Text("\(samplerReceiptData.insuranceExpense)원")
                }.padding()
                
                HStack {
                    Text("비급여")
                        .foregroundStyle(.secondary)
                        .bold()
                    Spacer()
                    Text("0원")
                }.padding()
                
                Divider()
                HStack {
                    Text("총 수납금액")
                        .foregroundStyle(.selection)
                        .bold()
                    Spacer()
                    Text("\(samplerReceiptData.totalAmount)원")
                }
                .padding()
                .font(.title2)
                Spacer()
            }
        }
       
        
       
    }
}

#Preview {
    PillReceiptView()
}
