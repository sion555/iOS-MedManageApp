//
//  CustomCalenderView.swift
//  iOS-MedManager
//
//  Created by ksy on 6/3/24.
//

import SwiftUI

struct CustomCalenderView: View {
    @Binding var currentDate: Date
    @State var currentMonth: Int = 0
    @State private var selectedDate: Date?
    let days = ["일", "월", "화", "수", "목", "금", "토"]
    let calendar = Calendar.current
    
    var body: some View {
        VStack(spacing: 35) {
            
            HStack(spacing: 20) {
        
                VStack(alignment: .leading) {
                    // 년, 월
                    Text(extraDate()[0])
                        .font(.caption)
                        .fontWeight(.semibold)
                    Text(extraDate()[1])
                        .font(.title)
                        .bold()
                }
                Spacer(minLength: 0)
                // 달력 버튼
                Button(action: {
                    withAnimation {
                        currentMonth -= 1
                        currentDate = getCurrentMonth()
                    }
                }, label: {
                    Image(systemName: "chevron.left.circle")
                        .font(.title2)
                })
                
                Button(action: {
                    withAnimation {
                        currentMonth += 1
                        currentDate = getCurrentMonth()
                    }
                }, label: {
                    Image(systemName: "chevron.right.circle")
                        .font(.title2)
                }).padding()
            }
            .padding(.horizontal)
            
            HStack {
                // 요일
                ForEach(days, id: \.self) { day in
                    Text(day)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(day == "토" ? .blue : (day == "일" ? .red : .primary))

                }
            }
            // 달력 일수 띄우기
            let columns = Array(repeating: GridItem(), count: 7)
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(extractDate()){ value in
                    CardView(value: value)
                        .font(.title3)
                }
            }
        }
        //뷰 초기화 시 현재 날짜 설정
        .onAppear {
            currentDate = getCurrentMonth()
        }
    }
    
    //@ViewBuilder
    //-1로 표시 되는 날짜 보이지 않도록 하기
    func CardView(value: DateValue) -> some View {
        VStack {
            if value.day != -1 {
                Text("\(value.day)")
                    .font(.title3)
                    .bold()
            }
        }
        .padding(.vertical, 8)
        .frame(height: 60, alignment: .top)
    }
    
    //해당 달의 날짜를 요일 별로 배열
    func extractDate() -> [DateValue] {
        let currentMonth = getCurrentMonth()
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            let day = calendar.component(.day, from: date)
            return DateValue(day: day, date: date)
        }
        
        //주어진 달의 1일 요일 계산
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        // 1일 이전 달력의 없는 날짜를 -1로 표시
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return days
    }
    
    //해당 달의 Date 가져오기
    func getCurrentMonth() -> Date {
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
            return Date()
        }
        return currentMonth
    }
    
    //해당 년도와 달 포멧팅
    func extraDate() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MMMM"
        
        let date = formatter.string(from: currentDate)
        return date.components(separatedBy: " ")
    }
}




#Preview {
    CustomCalenderView(currentDate:.constant(Date()))
}
