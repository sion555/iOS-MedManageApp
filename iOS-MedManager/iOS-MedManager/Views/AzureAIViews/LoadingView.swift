//
//  ProgressView.swift
//  iOS-MedManager
//
//  Created by 한범석 on 6/13/24.
//

import SwiftUI

struct LoadingView: View {
    @ObservedObject var aiViewModel: AzureDocumentIntelligenceViewModel

    var body: some View {
        VStack {
            Text("응답 받아오는 중...")
                .font(.title)
                .padding()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(2)
                .padding()
        }
        .navigationTitle("로딩 중")
    }
}

#Preview {
    LoadingView(aiViewModel: AzureDocumentIntelligenceViewModel())
}




