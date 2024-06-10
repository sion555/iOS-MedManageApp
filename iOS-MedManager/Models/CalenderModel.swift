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
    //월의 모든 날짜를 가져올때 사용
    func getAllDates() -> [Date] {
        let calendar = Calendar.current
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        return range.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
    
        // 현재 날짜의 월의 시작 날짜를 반환하는 메서드
    func startOfMonth() -> Date {
        let calendar = Calendar.current
        
        // 현재 날짜의 연도와 월을 기반으로 해당 월의 첫 번째 날짜를 계산합니다.
        let components = calendar.dateComponents([.year, .month], from: self)
        return calendar.date(from: components)!
    }
    
    //현재 날짜의 월의 끝 날짜를 반환하는 메서드
    func endOfMonth() -> Date {
            let calendar = Calendar.current
            
            // 다음 달의 시작 날짜를 계산합니다.
            let startOfNextMonth = calendar.date(byAdding: DateComponents(month: 1), to: startOfMonth())!
            
            // 다음 달의 시작 날짜에서 1초를 빼서 현재 달의 마지막 날짜를 계산합니다.
            return calendar.date(byAdding: DateComponents(second: -1), to: startOfNextMonth)!
        }
}


//일정 정보
 
//struct Schedule: Decodable {
//    var name: String
//    var startDate: Date
//    var endDate: Date
//    
//    
//     //일정 표시 색깔 지정
//    var color = Color(red: Double.random(in: 0.0...1.0), green: Double.random(in: 0.0...1.0), blue: Double.random(in: 0.0...1.0))
//    
//    enum CodingKeys: String, CodingKey {
//        case name, startDate, endDate
//    }
//}

