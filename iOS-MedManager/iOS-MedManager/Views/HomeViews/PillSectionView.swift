//
//  PillSectionView.swift
//  iOS-MedManager
//
//  Created by 한범석 on 6/10/24.
//

import SwiftUI

struct PillSectionView: View {
    let title: String
    let pills: [Pills]
    @Binding var isExpanded: Bool
    @Binding var progress: Double
    @ObservedObject var viewModel: HomeMainViewModel
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "pills")
                    .foregroundStyle(.gray)
                Text("\(title) \(pills.count)개")
                    .font(.headline)
                Spacer()
                Button(action: {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }) {
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundStyle(.blue)
                }
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(10)

            if isExpanded {
                ForEach(pills) { pill in
                    PillRowView(pill: pill) {
                        viewModel.togglePill(pill: pill)
                    }
                }
            }
        }
        .padding(.vertical, 5)
    }
}



//#Preview {
//
//}
