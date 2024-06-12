//
//  Calendar.swift
//  CalendarTest
//
//  Created by 이유경 on 6/10/24.
//

import Foundation
import SwiftUI

struct CalendarTest: UIViewRepresentable {
    var calendarIdentifier: Calendar.Identifier = .gregorian
    let canSelect: Bool
    @Binding var selectedDate: Date?
    
    var dateInterval: DateInterval {
        let calendar = Calendar(identifier: calendarIdentifier)
        
        // Get the start date of the current year
        guard let startDate = calendar.date(from: calendar.dateComponents([.year], from: Date())),
              // Get the end date of the current year
              let endDate = calendar.date(byAdding: .year, value: 1, to: startDate)
        else { return DateInterval() }
        
        // Return the date interval covering the entire year
        return DateInterval(start: startDate, end: endDate)
    }
    
    func makeCoordinator() -> CalendarCoordinator {
        CalendarCoordinator(calendarIdentifier: calendarIdentifier, canSelect: canSelect, selectedDate: $selectedDate)
    }
    
    func makeUIView(context: Context) -> UICalendarView {
        let view = UICalendarView()
        view.availableDateRange = dateInterval
        view.calendar = Calendar(identifier: calendarIdentifier)
        if canSelect {
            view.selectionBehavior = UICalendarSelectionSingleDate(delegate: context.coordinator)
        }
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: UICalendarView, context: Context) {
        let calendar = Calendar(identifier: calendarIdentifier)
        uiView.calendar = calendar

        // Get the start and end dates of the selected month
        guard let selectedDate = selectedDate,
              let startDate = calendar.date(from: calendar.dateComponents([.year, .month], from: selectedDate)),
              let endDate = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startDate)
        else {
            return
        }

        // Populate components with all dates in the selected month
        var components = Set<DateComponents>()
        var currentDate = startDate
        while currentDate <= endDate {
            let dateComponents = calendar.dateComponents([.year, .month, .day], from: currentDate)
            components.insert(dateComponents)
            guard let nextDate = calendar.date(byAdding: .day, value: 1, to: currentDate) else { break }
            currentDate = nextDate
        }

        // Reload decorations for all dates in the selected month
        uiView.reloadDecorations(forDateComponents: Array(components), animated: true)
    }
}

final class CalendarCoordinator: NSObject, UICalendarSelectionSingleDateDelegate, UICalendarViewDelegate {
    var calendarIdentifier: Calendar.Identifier
    let canSelect: Bool
    @Binding var selectedDate: Date?
    var pickedDate: Date?
    var calendar: Calendar {
        Calendar(identifier: calendarIdentifier)
    }
    
    init(calendarIdentifier: Calendar.Identifier, canSelect: Bool, selectedDate: Binding<Date?>) {
        self.calendarIdentifier = calendarIdentifier
        self.canSelect = canSelect
        self._selectedDate = selectedDate
    }

    func dateSelection(_ selection: UICalendarSelectionSingleDate, canSelectDate dateComponents: DateComponents?) -> Bool {
        return true
    }
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let dateComponents,
              let date = calendar.date(from: dateComponents)
        else { return }
        self.selectedDate = date
    }
    
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        guard let day = dateComponents.day else { return nil }
        if day == 1 {
            return .default(color: .red, size: .large)
        } else if day == 2 {
            return .default(color: .blue, size: .large)
        } else if day == 3 {
            return .default(color: .green, size: .large)
        } else if day == 4 {
            return .default(color: .yellow, size: .large)
        } else if day == 5 {
            return .default(color: .purple, size: .large)
        } else if day == 6 {
            return .default(color: .cyan, size: .large)
        } else if day == 7 {
            return .default(color: .magenta, size: .large)
        } else {
            return nil
        }
    }
}
