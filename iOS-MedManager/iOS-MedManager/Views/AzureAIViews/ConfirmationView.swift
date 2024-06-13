//
//  ConfirmationView.swift
//  iOS-MedManager
//
//  Created by 한범석 on 6/13/24.
//

import SwiftUI

struct ConfirmationView: View {
    @Binding var isPresented: Bool
    var pillName: String
    var pillType: String
    var instruction: String

    var body: some View {
        VStack {
            Text("인식된 정보가 이게 맞나요?")
                .font(.title)
                .padding()
            Form {
                Section(header: Text("Pill Name")) {
                    TextField("Pill Name", text: .constant(pillName))
                }
                Section(header: Text("Pill Type")) {
                    TextField("Pill Type", text: .constant(pillType))
                }
                Section(header: Text("Instruction")) {
                    TextField("Instruction", text: .constant(instruction))
                }
            }
            .padding()
        }
        .navigationTitle("정보 확인")
    }
}

#Preview {
    ConfirmationView(isPresented: .constant(true), pillName: "Sample Pill", pillType: "Sample Type", instruction: "Sample Instruction")
}


