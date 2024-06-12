//
//  PillReceiptView.swift
//  iOS-MedManager
//
//  Created by ksy on 6/5/24.
//

import SwiftUI

struct PillReceiptView: View {
    
    var body: some View {
        List {
            VStack {
                Spacer()
                Text("좋은약국")
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
                    Text("4,000원")
                    
                }.padding()
                HStack {
                    Text("보험자부담금")
                        .foregroundStyle(.secondary)
                        .bold()
                    Spacer()
                    Text("8,000원")
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
                    Text("4,000원")
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
