//
//  PillRowView.swift
//  iOS-MedManager
//
//  Created by 한범석 on 6/10/24.
//

import SwiftUI

struct PillRowView: View {
    let pill: Pills
    
    var body: some View {
        HStack {
            Image(systemName: "pills")
            Text(pill.pillName)
            Spacer()
            Text(pill.doseTime ?? "")
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
    }
}

let samplePill = Pills(
        pillID: 1,
        pillName: "Sample Pill",
        pillImage: "image1.jpg",
        pillDescription: "Sample Description",
        pillType: "Sample Type",
        storageMethod: "Room Temperature",
        medicineEffect: "Sample Effect",
        prescriptionID: 1,
        doseTime: "morning",
        instruction: Instruction(
            instructionID: 1,
            prescriptionID: 1,
            pillID: 1,
            instruction: "Sample Instruction"
        )
    )

#Preview {
    PillRowView(pill: samplePill)
}
