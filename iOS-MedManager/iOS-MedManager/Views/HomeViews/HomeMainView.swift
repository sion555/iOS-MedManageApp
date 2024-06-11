//
//  HomeMainView.swift
//  iOS-MedManager
//
//  Created by 한범석 on 6/9/24.
//

import SwiftUI

struct HomeMainView: View {
    @StateObject private var viewModel = HomeMainViewModel()
    @State private var isMorningExpanded = false
    @State private var isAfternoonExpanded = false
    @State private var isEveningExpanded = false
    @State private var showingPopup = false
    @State private var navigateToSearchView = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Date and Total Pills Info
                VStack(alignment: .leading) {
                    Text(viewModel.currentDate)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .padding(.bottom, 2)
                    
                    HStack {
                        Text("오늘 복용해야하는 약은")
                            .font(.title3)
                        +
                        Text(" 총 \(viewModel.totalPills)개 ")
                            .font(.title3)
                            .foregroundStyle(.blue)
                        +
                        Text("입니다")
                            .font(.title3)
                    }
                }
                
                // Progress Circle
                ProgressCircleView(progress: $viewModel.progress)
                
                // Other Date Button
                Button(action: {
                    viewModel.showingDatePicker.toggle()
                }) {
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundStyle(.blue)
                        Text("다른 날짜 복약정보")
                            .foregroundStyle(.blue)
                    }
                }
                .sheet(isPresented: $viewModel.showingDatePicker) {
                    DatePickerView(selectedDate: $viewModel.selectedDate)
                }

                // Pill Sections
                PillSectionView(title: "아침", pills: viewModel.morningPills, isExpanded: $isMorningExpanded, progress: $viewModel.progress, viewModel: <#HomeMainViewModel#>)
                PillSectionView(title: "점심", pills: viewModel.afternoonPills, isExpanded: $isAfternoonExpanded, progress: $viewModel.progress, viewModel: <#HomeMainViewModel#>)
                PillSectionView(title: "저녁", pills: viewModel.eveningPills, isExpanded: $isEveningExpanded, progress: $viewModel.progress, viewModel: <#HomeMainViewModel#>)

                Spacer()
                
                // Add Pill Button
                AddPillButtonView(showingPopup: $showingPopup, navigateToSearchView: $navigateToSearchView)
            }
            .padding()
            .navigationDestination(isPresented: $navigateToSearchView) {
//                SearchView()
            }
        }
    }
}


#Preview {
    HomeMainView()
}

