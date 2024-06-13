//
//  InstructionView.swift
//  iOS-MedManager
//
//  Created by 한범석 on 6/13/24.
//

import SwiftUI

struct InstructionView: View {
    @Binding var isPresented: Bool
    @Binding var selectedImage: UIImage?

    var body: some View {
        VStack {
            Text("사진 찍는 방법 안내")
                .font(.title)
                .padding()
            Spacer()
            Button("확인") {
                isPresented = true
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .navigationTitle("사진 찍기 안내")
    }
}

#Preview {
    InstructionView(isPresented: .constant(true), selectedImage: .constant(nil))
}


