//
//  HomeMainView.swift
//  iOS-MedManager
//
//  Created by ksy on 6/3/24.
//

import SwiftUI

struct HomeMainView: View {
    let dateString: String
    
    //Gauge
    @State var progress: Double = 0.5
    @State var current: Double = 50.0
    var minValue: Double = 0
    var maxValue: Double = 100
    
    init() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        self.dateString = dateFormatter.string(from: date)
    }
    
    var body: some View {
        NavigationStack {
            HStack {
                Button(action: {}, label: {
                    Image(systemName: "chevron.left.circle")
                })
                Spacer()
                Text(dateString)
                    .foregroundStyle(.black)
                    .bold()
                Spacer()
                Button(action: {}, label: {
                    Image(systemName: "chevron.right.circle")
                })
                
            }.padding()
            
            VStack(alignment: .trailing) {
                Image(systemName: "bell")
                
                HStack {
                    Image("약톡톡 고양이메인캐릭터")
                        .resizable()
                        .frame(width: 100, height: 100)
                    VStack(alignment: .leading){
                        
                        Text("오늘 복용 해야하는 약은")
                            .font(.title2)
                        Text("총 12개 입니다")
                            .font(.title2)
                            .foregroundStyle(.orange)
                            .bold()
                        
                    }
                    
                    Gauge(value: progress, label: { Text("\(Int(current))%") })
                    
                        .padding()
                        .gaugeStyle(.accessoryCircularCapacity)
                        .foregroundStyle(.blue)
                    
                }
                //아래 버튼을 네비게이션 뷰 연결해야함
                NavigationLink {
                    PillReceiptView()
                } label: {
                    Text("영수증 내역 확인")
                        .frame(width: 300, height: 5)
                        .padding()
                        .foregroundStyle(.white)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                NavigationLink {
                    PillAddView()
                } label: {
                    Text("약 추가")
                        .frame(width: 300, height: 5)
                        .padding()
                        .foregroundStyle(.white)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
        }
    }
}

#Preview {
    HomeMainView()
}
