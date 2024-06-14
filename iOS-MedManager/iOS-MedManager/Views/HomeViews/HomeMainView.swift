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
    @State private var isShowingPopup = false
    
    @State private var showingDatePicker = false
    @State private var showingCameraView = false
    @State private var showingImageReviewView = false
    @State private var showingLoadingView = false
    @State private var showingConfirmationView = false
    @State private var showingInstructionView = false
    
    @State private var selectedImage: UIImage?
    @State private var isUploading = false
    
    @StateObject private var aiViewModel = AzureDocumentIntelligenceViewModel()
    
    @State private var buttonFrame: CGRect = .zero

    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 20) {
                    // Date and Total Pills Info
                    VStack(alignment: .leading) {
                        Text(viewModel.currentDate)
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                            .padding(.bottom, 2)
                        
                        HStack {
                            Text("오늘 복용해야하는 약은\n")
                                .font(.title3)
                            +
                            Text("총 \(viewModel.totalPills)개 ")
                                .font(.title3)
                                .foregroundStyle(.blue)
                            +
                            Text("입니다")
                                .font(.title3)
                            
                            Spacer()
                            // Progress Circle
                            ProgressCircleView(progress: $viewModel.progress)
                        }
                    }
                    .padding(.leading, 10)
                    
                    // Other Date Button
                    Button(action: {
                        withAnimation(.easeInOut) {
                            showingDatePicker.toggle()
                        }
                    }) {
                        HStack {
                            Image(systemName: "calendar")
                                .foregroundStyle(.blue)
                            Text("다른 날짜 복약정보")
                                .foregroundStyle(.blue)
                        }
                    }
                    
                    // Pill Sections
                    ScrollView {
                        VStack(spacing: 20) {
                            // Pill Sections
                            PillSectionView(title: "아침", pills: viewModel.morningPills, isExpanded: $isMorningExpanded, progress: $viewModel.progress, viewModel: viewModel)
                            PillSectionView(title: "점심", pills: viewModel.afternoonPills, isExpanded: $isAfternoonExpanded, progress: $viewModel.progress, viewModel: viewModel)
                            PillSectionView(title: "저녁", pills: viewModel.eveningPills, isExpanded: $isEveningExpanded, progress: $viewModel.progress, viewModel: viewModel)
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                    .padding(.bottom)
                    Spacer()
                }
                .padding()
                
                // Date Picker Popup
                if showingDatePicker {
                    VStack {
                        Spacer()
                        
                        VStack(spacing: 20) {
                            DatePicker("Select a date", selection: $viewModel.selectedDate, displayedComponents: .date)
                                .datePickerStyle(GraphicalDatePickerStyle())
                            
                            Button("완료") {
                                viewModel.fetchPrescriptions(for: viewModel.selectedDate)
                                withAnimation(.easeInOut) {
                                    showingDatePicker = false
                                }
                            }
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .padding(.bottom, 40)
                        .frame(maxWidth: .infinity)
                        Spacer()
                    }
                    .transition(.scale)
                }
                
                // 약 추가 버튼
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            withAnimation(.easeInOut) {
                                isShowingPopup.toggle()
                            }
                        }) {
                            HStack {
                                Image(systemName: isShowingPopup ? "xmark.circle.fill" : "plus.circle.fill")
                                    .font(.title)
                                Text(isShowingPopup ? "취소" : "약 추가")
                                    .font(.title3)
                            }
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(30)
                        }
                        .padding(.bottom, 20)
                        .padding(.trailing, 10)
                    }
                }
                
                // 팝업 창 부분
                if isShowingPopup {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation {
                                isShowingPopup = false
                            }
                        }
                    
                    VStack {
                        Spacer()
                        
                        HStack {
                            Spacer()
                            VStack(spacing: 20) {
                                NavigationLink(destination: InstructionView()) {
                                    HStack {
                                        Image(systemName: "camera")
                                        Text("약 봉투 촬영")
                                    }
                                }
                                
                                NavigationLink(destination: Text("SearchView는 만드는 중입니다")) {
                                    HStack {
                                        Image(systemName: "pencil")
                                        Text("직접 입력")
                                    }
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding()
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: buttonFrame.height) // 버튼의 높이만큼 공간 확보
                    }
                    .padding(.bottom, buttonFrame.height + 140) // 버튼의 높이만큼 공간 확보
                }
            }
            .navigationDestination(isPresented: $showingImageReviewView) {
                ImageReviewView(isPresented: $showingImageReviewView, selectedImage: $selectedImage, aiViewModel: aiViewModel, showingLoadingView: $showingLoadingView)
            }
        }
    }
}

#Preview {
    HomeMainView()
}


//            .navigationDestination(isPresented: $showingLoadingView) {
//                LoadingView(aiViewModel: aiViewModel)
//                    .onAppear {
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                            showingLoadingView = false
//                            if aiViewModel.result != "" {
//                                showingConfirmationView = true
//                            } else {
//                                showingImageReviewView = true
//                            }
//                        }
//                    }
//            }
//            .navigationDestination(isPresented: $showingConfirmationView) {
//                ConfirmationView(isPresented: $showingConfirmationView, pillName: aiViewModel.result, pillType: aiViewModel.result, instruction: aiViewModel.result)
//            }







