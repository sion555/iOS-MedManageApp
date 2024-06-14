//
//  ImageReviewView.swift
//  iOS-MedManager
//
//  Created by 한범석 on 6/13/24.
//

import SwiftUI

struct ImageReviewView: View {
    @Binding var isPresented: Bool
    @Binding var selectedImage: UIImage?
    @ObservedObject var aiViewModel: AzureDocumentIntelligenceViewModel
    @Binding var showingLoadingView: Bool

    var body: some View {
        VStack {
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .padding()
            }
            Spacer()
            HStack {
                Button("다시 찍기") {
                    isPresented = false
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Button("전송") {
                    if let image = selectedImage, let imageData = image.jpegData(compressionQuality: 1.0) {
                        showingLoadingView = false
//                        aiViewModel.analyzeImage(imageData: imageData)
                        isPresented = false
                    }
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .navigationTitle("이미지 확인")
        .navigationDestination(isPresented: $isPresented) {
            LoadingView(aiViewModel: aiViewModel)
        }
    }
}

#Preview {
    ImageReviewView(isPresented: .constant(true), selectedImage: .constant(UIImage(named: "sample_image")), aiViewModel: AzureDocumentIntelligenceViewModel(), showingLoadingView: .constant(false))
}





