//
//  ProgressCircleView.swift
//  iOS-MedManager
//
//  Created by 한범석 on 6/10/24.
//

import SwiftUI

struct ProgressCircleView: View {
    @Binding var progress: Double

    var body: some View {
        Circle()
            .trim(from: 0.0, to: progress)
            .stroke(lineWidth: 5)
            .foregroundStyle(progress == 1.0 ? .green : .blue)
            .frame(width: 100, height: 100)
            .overlay(
                Text("\(Int(progress * 100))%")
                    .font(.title2)
                    .foregroundStyle(progress == 1.0 ? .green : .blue)
            )
            .rotationEffect(Angle(degrees: 0))
            .animation(.easeInOut(duration: 1.0), value: progress)
    }
}

#Preview {
    ProgressCircleView(progress: .constant(0.5))
}
