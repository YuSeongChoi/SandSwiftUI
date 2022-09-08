//
//  SalaryViewModel.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/09/01.
//

import SwiftUI

@MainActor
final class SalaryViewModel: ObservableObject, Identifiable {
    private(set) var years: [Date] = []
    @Published var months: [Date] = []
    @Published var selectedYear: Date = Date().addYear(n: 0)
    
    func insertDefaultYears() {
        years.removeAll()
        for i in 0..<6 {
            years.append(Date().addYear(n: -i))
        }
        insertDefaultMonths()
    }
    
    func insertDefaultMonths() {
        months.removeAll()
        if selectedYear.year != Date().year {
            selectedYear = selectedYear.startOfYear.addMonth(n: 11)
        } else {
            selectedYear = Date().addYear(n: 0)
        }
        for i in 0..<selectedYear.month {
            months.append(selectedYear.addMonth(n: -i))
        }
        months = months.sorted()
    }
    
    func limitMinimumYear() -> Bool {
        return selectedYear.year == Date().addYear(n: -6).year
    }
    
    func limitMaximumYear() -> Bool {
        return selectedYear.year == Date().year
    }
    
    func dateToStringYear(date: Date) -> String {
        return date.string(format: "YYYY년")
    }
    
    func dateToStringMonth(date: Date) -> String {
        return date.string(format: "YYYY / MM")
    }
}
