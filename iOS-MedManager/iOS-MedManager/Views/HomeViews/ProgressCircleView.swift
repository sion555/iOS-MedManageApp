//
//  ProgressCircleView.swift
//  iOS-MedManager
//
//  Created by 한범석 on 6/10/24.
//

import SwiftUI

//struct ProgressCircleView: View {
//    @Binding var progress: Double
//
//    var body: some View {
//        Circle()
//            .trim(from: 0.0, to: progress)
//            .stroke(lineWidth: 5)
//            .foregroundStyle(progress == 1.0 ? .green : .blue)
//            .frame(width: 100, height: 100)
//            .overlay(
//                Text("\(Int(progress * 100))%")
//                    .font(.title2)
//                    .foregroundStyle(progress == 1.0 ? .green : .blue)
//            )
//            .rotationEffect(Angle(degrees: 0))
//            .animation(.easeInOut(duration: 1.0), value: progress)
//    }
//}

struct ProgressCircleView: View {
    @Binding var progress: Double

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 10.0)
                .opacity(0.3)
                .foregroundColor(.blue)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(.blue)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear, value: progress)
            
            Text(String(format: "%.0f%%", min(self.progress, 1.0)*100.0))
                .font(.title)
                .bold()
        }
        .padding()
    }
}


#Preview {
    ProgressCircleView(progress: .constant(0.5))
}
