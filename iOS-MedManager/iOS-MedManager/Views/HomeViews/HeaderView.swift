//
//  HeaderView.swift
//  iOS-MedManager
//
//  Created by 한범석 on 6/10/24.
//

import SwiftUI

struct HeaderView: View {
    let currentDate: String
    let totalPills: Int
    
    var body: some View {
        VStack(spacing: 10) {
            Text(currentDate)
                .font(.subheadline)
            Text("오늘 복용해야 하는 약은")
                .font(.headline)
            Text("총 \(totalPills)개 입니다")
                .foregroundColor(.blue)
            Button(action: {}) {
                HStack {
                    Image(systemName: "calendar")
                    Text("다른 날짜 복약정보")
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            }
        }
        .padding()
    }
}

#Preview {
    HeaderView(currentDate: "6월 10일", totalPills: 10)
}
