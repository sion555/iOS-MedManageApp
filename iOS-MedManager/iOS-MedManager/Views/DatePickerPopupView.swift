//
//  DatePickerPopupView.swift
//  iOS-MedManager
//
//  Created by 한범석 on 6/12/24.
//

import SwiftUI

struct DatePickerPopupView: View {
    @Binding var selectedDate: Date
    var onDateSelected: (Date) -> Void
    
    var body: some View {
        VStack {
            DatePicker("Select a date", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
            
            Button("완료") {
                onDateSelected(selectedDate)
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}

//#Preview {
//   DatePickerPopupView()
//}
