//
//  CalenderModel.swift
//  iOS-MedManager
//
//  Created by ksy on 6/3/24.
//
import SwiftUI
import Foundation

struct DateValue: Identifiable {
    var id = UUID()
    var day: Int
    var date: Date
}

//해당 달의 모든 날짜 Date
extension Date {
    func getAllDates() -> [Date] {
        let calendar = Calendar.current
        
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        return range.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
}


//일정 정보
 
struct Schedule: Decodable {
    var name: String
    var startDate: Date
    var endDate: Date
    
    
     //일정 표시 색깔 지정
    var color = Color(red: Double.random(in: 0.0...1.0), green: Double.random(in: 0.0...1.0), blue: Double.random(in: 0.0...1.0))
    
    enum CodingKeys: String, CodingKey {
        case name, startDate, endDate
    }
}

