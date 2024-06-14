//
//  InstructionView.swift
//  iOS-MedManager
//
//  Created by 한범석 on 6/13/24.
//

import SwiftUI

struct InstructionView: View {
    @State var showingCameraView: Bool = false
    @State var showingConfirmationView: Bool = false
    @State var image: UIImage?
    
    @StateObject var aiViewModel = AzureDocumentIntelligenceViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if let image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .padding()
                    
                    if aiViewModel.result.isEmpty {
                        Button("사진 분석") {
                            analyzeImage(image: image)
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    } else {
                        NavigationLink(destination: ConfirmationView(isPresented: $showingConfirmationView, result: aiViewModel.result)) {
                            Text("결과 확인")
                        }
                    }
                } else {
                    Text("사진 찍는 방법 안내") // 가이드 이미지가 들어갈 자리
                        .font(.title)
                        .padding()
                    Spacer()
                    Button("촬영") {
                        showingCameraView = true
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .navigationTitle("사진 찍기 안내")
            .sheet(isPresented: $showingCameraView) {
                CameraView(image: $image)
            }
        }
    }
    
    private func analyzeImage(image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }
        aiViewModel.analyzeImage(imageData: imageData)
    }
}

#Preview {
    InstructionView()
}




//                    .onDisappear {
//                        if selectedImage != nil {
//                            showingImageReviewView = true
//                        }
//                    }
