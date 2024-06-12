//
//  DatePickerView.swift
//  iOS-MedManager
//
//  Created by 한범석 on 6/11/24.
//

import SwiftUI

struct DatePickerView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedDate: Date
    
    var body: some View {
        VStack {
            DatePicker("Select a date", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
            
            Button("완료") {
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            .background(Color.blue)
            .foregroundStyle(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}
//
//#Preview {
//    DatePickerView(selectedDate: .constant())
//}
