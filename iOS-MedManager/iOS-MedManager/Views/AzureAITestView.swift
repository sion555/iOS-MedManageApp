//
//  AzureAITestView.swift
//  iOS-MedManager
//
//  Created by 한범석 on 6/5/24.
//

import SwiftUI

struct AzureAITestView: View {
    
    @StateObject private var viewModel = AzureDocumentIntelligenceViewModel()
    @State private var showImagePicker = false
    @State private var showCameraPicker = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
        VStack {
            Button(action: {
                if let imagePath = Bundle.main.path(forResource: "test-image", ofType: "jpg"),
                   let imageData = try? Data(contentsOf: URL(fileURLWithPath: imagePath)) {
                    viewModel.analyzeImage(imageData: imageData)
                } else {
                    viewModel.result = "Failed to load image."
                }
            }) {
                Text("프로젝트 파일에 포함된 이미지 분석")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            Button(action: {
                showImagePicker = true
            }) {
                Text("앨범에서 약 봉투 이미지 선택")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $selectedImage, sourceType: .photoLibrary)
            }
            
            Button(action: {
                showCameraPicker = true
            }) {
                Text("카메라로 약 봉투 이미지 촬영")
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .sheet(isPresented: $showCameraPicker) {
                ImagePicker(image: $selectedImage, sourceType: .camera)
            }
            
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .padding()
                
                Button(action: {
                    if let imageData = image.jpegData(compressionQuality: 1.0) {
                        viewModel.analyzeImage(imageData: imageData)
                    }
                }) {
                    Text("Analyze Selected Image")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            
            Text(viewModel.result)
                .padding()
                .font(.system(size: 10))
        }
        .padding()
    }
}


#Preview {
    AzureAITestView()
}
