//
//  CalendarView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/10/31.
//

import SwiftUI

struct CalendarView: View {
    
    @Binding var selectedDate:Date
    
    let borderColor: Color = Color(.systemGray5)
    
    var dayOfTheWeek = ["일","월","화","수","목","금","토"]
    
    var daysInMonth:Int {
        let range = Calendar.current.range(of: .day , in: .month, for: selectedDate)
        return range?.count ?? 0
    }
    
    var firstDayOfMonth:Date {
        let components = Calendar.current.dateComponents([.year, .month], from: selectedDate)
        return Calendar.current.date(from: components) ?? Date()
    }
    
    var startingSpaces:Int {
        let components = Calendar.current.dateComponents([.weekday], from: firstDayOfMonth)
        return (components.weekday ?? 0) - 1
    }
    var start:Int {
        startingSpaces == 0 ? startingSpaces + 7 : startingSpaces
    }
    
    
    var body: some View {
        VStack(spacing: 0) {
            HStack{
                ForEach(dayOfTheWeek, id: \.self) { day in
                    Text(day)
                        .foregroundColor(day == "일" ? .red : .black)
                        .frame(maxWidth: .infinity, maxHeight: 52 ,alignment: .center)
                }
            }.border(borderColor, width: 1)
            
            VStack(spacing: 0) {
                ForEach(0..<6) { row in
                    HStack(spacing: 0){
                        ForEach(1..<8){ column in
                            let count:Int = column + (row * 7)
                            let day:Int = count - start
                            if day < 1 || (count - start > daysInMonth){
                                Text("")
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                            } else{
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
}


