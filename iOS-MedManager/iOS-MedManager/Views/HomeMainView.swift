//
//  HomeMainView.swift
//  iOS-MedManager
//
//  Created by 한범석 on 6/9/24.
//

import SwiftUI

struct HomeMainView: View {
    @StateObject private var viewModel = HomeMainViewModel()
    @State private var selectedDoseTime: String?
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(viewModel.currentDate)
                    .font(.headline)
                    .padding()
                
                Text("오늘 복용해야 하는 약은 총 \(viewModel.totalPills)개 입니다")
                    .font(.title2)
                    .padding(.bottom, 10)
                
                ProgressView(value: viewModel.progress)
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(1.5)
                    .padding(.bottom, 20)
                
                ScrollView {
                    ForEach(viewModel.doseTimes, id: \.self) { doseTime in
                        Section(header: HStack {
                            Text(doseTime)
                                .font(.headline)
                            Spacer()
                            Button(action: {
                                selectedDoseTime = selectedDoseTime == doseTime ? nil : doseTime
                            }) {
                                Image(systemName: selectedDoseTime == doseTime ? "chevron.down" : "chevron.right")
                            }
                        }) {
                            if selectedDoseTime == doseTime {
                                ForEach(viewModel.pills.filter { $0.doseTime?.contains(doseTime) ?? false }, id: \.pillID) { pill in
                                    PillRowView(pill: pill)
                                }
                            }

                        }
                    }
                }
                
                Spacer()
                
                Button(action: {
                    // 약 추가 액션
                }) {
                    Text("약 추가")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.bottom)
            }
            .padding()
            .navigationTitle("홈")
            .onAppear {
                viewModel.fetchPrescriptions()
            }
            .alert(viewModel.alertMessage, isPresented: $viewModel.showingAlert) {
                Button("확인", role: .cancel) { }
            }
        }
    }
}

#Preview {
    HomeMainView()
}

