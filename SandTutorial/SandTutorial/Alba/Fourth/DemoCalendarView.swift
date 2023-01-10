//
//  DemoCalendarView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2023/01/06.
//

import SwiftUI

struct DemoCalendarView: View {
    
    @Environment(\.calendar) private var calendar

    @State private var selectedDate: Date = Date()
    
    private let borderColor: Color = Color(.systemGray5)
    
    private let dayOfTheWeek = ["일","월","화","수","목","금","토"]
    
    private var daysInMonth:Int {
        let range = Calendar.current.range(of: .day , in: .month, for: selectedDate)
        return range?.count ?? 0
    }
    
    private var firstDayOfMonth:Date {
        // 년, 월 구하기
        let components = Calendar.current.dateComponents([.year, .month], from: selectedDate)
        return Calendar.current.date(from: components) ?? Date()
    }
    
    private var startingSpaces:Int {
        // 달력이 시작하는 시작점
        let components = Calendar.current.dateComponents([.weekday], from: firstDayOfMonth)
        return (components.weekday ?? 0) - 1
    }
    
    // 달력의 시작요일(시작점) 구하기
    private var start:Int {
        startingSpaces == 0 ? startingSpaces + 7 : startingSpaces
    }
    
    
    var body: some View {
        VStack(spacing: 0) {
            calendarHeaderView()
            Divider()
            HStack{
                // 일 ~ 토
                ForEach(dayOfTheWeek, id: \.self) { day in
                    Text(day)
                        .foregroundColor(day == "일" ? .red : .black)
                        .frame(maxWidth: .infinity, maxHeight: 52 ,alignment: .center)
                }
            }.border(borderColor, width: 1)
            
            VStack(spacing: 0) {
                // 요일
                ForEach(0..<6) { row in
                    HStack(spacing: 0) {
                        // 한달 일수
                        ForEach(1..<8) { column in
                            let count:Int = column + (row * 7)
                            let day:Int = count - start
                            if day < 1 || (count - start > daysInMonth) {
                                Text("")
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                            } else {
                                Text(String(day))
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                                    .foregroundColor(column == 1 ? .red : .black)
                                    .onTapGesture {
                                        print("Tap row : \(row), column : \(column)")
                                    }
                            }
                        }
                        .padding(.top, 1)
                        .border(borderColor, width: 1)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func calendarHeaderView() -> some View {
        HStack(alignment: .bottom) {
            Button {
                if let newDate = calendar.date(byAdding: .month, value: -1, to: selectedDate) {
                    selectedDate = newDate
                }
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .foregroundColor(.black)
                    .padding(2)
                    .border(.gray, width: 1)
                    .frame(alignment: .bottomLeading)
            }
            
            Spacer()
            
            VStack {
                Text(calendar.component(.year, from: selectedDate).description)
                    .font(.system(size: 10, weight: .regular))
                    .foregroundColor(.gray)
                Text("\(calendar.component(.month, from: selectedDate)) 월")
                    .font(.system(size: 22, weight: .bold))
            }
            
            Spacer()
            
            Button {
                if let newDate = calendar.date(byAdding: .month, value: 1, to: selectedDate) {
                    selectedDate = newDate
                }
            } label: {
                Image(systemName: "chevron.right")
                    .font(.title3)
                    .foregroundColor(.black)
                    .padding(2)
                    .border(.gray, width: 1)
                    .frame(alignment: .bottomTrailing)
            }
        }
        .padding(EdgeInsets(top: 10, leading: 22, bottom: 10, trailing: 22))
    }
    
}
