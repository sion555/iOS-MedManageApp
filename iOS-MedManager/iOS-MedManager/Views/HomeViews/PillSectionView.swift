//
//  PillSectionView.swift
//  iOS-MedManager
//
//  Created by 한범석 on 6/10/24.
//

import SwiftUI

//struct PillSectionView: View {
//    var title: String
//    var pills: [Pills]
//    @Binding var isExpanded: Bool
//    @Binding var progress: Double
//    @ObservedObject var viewModel: HomeMainViewModel
//
//    var body: some View {
//        VStack {
//            HStack {
//                Text("\(title) \(pills.count)개")
//                Spacer()
//                Button(action: { isExpanded.toggle() }) {
//                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
//                }
//            }
//            .padding()
//            .background(Color(UIColor.systemGray6))
//            .cornerRadius(10)
//
//            if isExpanded {
//                ForEach(pills, id: \.id) { pill in
//                    PillRowView(pill: pill) {
//                        viewModel.togglePill(pill: pill)
//                    }
//                }
//            }
//        }
//        .padding(.vertical, 5)
//    }
//}


//struct PillSectionView: View {
//    let title: String
//    let pills: [Pills]
//    @Binding var isExpanded: Bool
//    @Binding var progress: Double
//    var viewModel: HomeMainViewModel
//
//    var body: some View {
//        VStack {
//            Button(action: {
//                withAnimation {
//                    isExpanded.toggle()
//                }
//            }) {
//                HStack {
//                    Text("\(title) \(pills.count)개")
//                        .font(.headline)
//                    Spacer()
//                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
//                }
//                .padding()
//                .background(Color(UIColor.systemGray6))
//                .cornerRadius(10)
//            }
//            
//            if isExpanded {
//                ForEach(pills) { pill in
//                    HStack {
//                        Text(pill.pillName)
//                        Spacer()
//                        Image(systemName: pill.isTaken ? "checkmark.circle.fill" : "circle")
//                            .onTapGesture {
//                                withAnimation {
//                                    viewModel.togglePill(pill: pill)
//                                }
//                            }
//                    }
//                    .padding()
//                    .background(Color(UIColor.systemGray5))
//                    .cornerRadius(10)
//                    .padding(.horizontal)
//                }
//            }
//        }
//    }
//}


struct PillSectionView: View {
    let title: String
    let pills: [Pills]
    @Binding var isExpanded: Bool
    @Binding var progress: Double
    var viewModel: HomeMainViewModel

    var body: some View {
        VStack {
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Text("\(title) \(pills.count)개")
                        .font(.headline)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                }
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
            }
            
            if isExpanded {
                ForEach(pills) { pill in
                    HStack {
                        Text(pill.pillName)
                        Spacer()
                        Image(systemName: pill.isTaken ? "checkmark.circle.fill" : "circle")
                            .onTapGesture {
                                withAnimation {
                                    viewModel.togglePill(pill: pill)
                                }
                            }
                    }
                    .padding()
                    .background(Color(UIColor.systemGray5))
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
            }
        }
    }
}



//#Preview {
//
//}
