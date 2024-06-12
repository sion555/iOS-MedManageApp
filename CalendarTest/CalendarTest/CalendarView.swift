//
//  CalendarView.swift
//  CalendarTest
//
//  Created by 이유경 on 6/10/24.
//

import SwiftUI

struct CalendarView: View {
    @State private var selectedIdentifier: Calendar.Identifier = .gregorian
    @State private var selectedDate: Date?
    
    private var textDate: String {
        guard let selectedDate else { return "Date not selected" }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: selectedDate)
    }
    
    var body: some View {
        VStack {
            Text("캘린더임")
                .font(.title)
                .frame(alignment: .leading)
                .bold()
            Text(textDate)
                .font(.title3)
            ScrollView(.vertical, content: {
                CalendarTest(canSelect: true, selectedDate: $selectedDate)
                    .scaledToFit()
            })
            .fixedSize()
        }
    }
}

#Preview {
    CalendarView()
}
