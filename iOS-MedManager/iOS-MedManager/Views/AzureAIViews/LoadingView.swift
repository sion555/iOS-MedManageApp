//
//  ProgressView.swift
//  iOS-MedManager
//
//  Created by 한범석 on 6/13/24.
//

import SwiftUI

struct LoadingView: View {
    @Binding var isPresented: Bool
    @ObservedObject var aiViewModel: AzureDocumentIntelligenceViewModel

    var body: some View {
        VStack {
            Text("전송 중...")
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
    LoadingView(isPresented: .constant(true), aiViewModel: AzureDocumentIntelligenceViewModel())
}



