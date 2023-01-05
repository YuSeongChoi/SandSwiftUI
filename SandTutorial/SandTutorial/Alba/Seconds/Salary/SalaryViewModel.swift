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
    @Published var employeeList: [EmployeeVO] = EmployeeVO.sampleData
    
    func checkAllEmployee() {
        
    }
    
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

struct EmployeeVO: Codable, Hashable, Sendable {
    /// 체크
    var checkToggle: Bool = false
    /// 직원명
    var name: String = ""
    /// 직원 주민번호
    var registerNumber: String = ""
    /// 총급여
    var totalSalary: Int = 0
    /// 공제액
    var deductedAmount: Int = 0
    /// 지급액
    var paymentAmount: Int = 0
    
    static var sampleData: [EmployeeVO] = [
        EmployeeVO(name: "한동숙", registerNumber: "890619-1*", totalSalary: 3000000, deductedAmount: 218400, paymentAmount: 2771600),
        EmployeeVO(name: "김삼식", registerNumber: "951121-1*", totalSalary: 2500000, deductedAmount: 145000, paymentAmount: 2355000),
        EmployeeVO(name: "이꼬마", registerNumber: "040220-3*", totalSalary: 300, deductedAmount: 4, paymentAmount: 296),
        EmployeeVO(name: "배준식", registerNumber: "960505-1*", totalSalary: 3400000, deductedAmount: 250000, paymentAmount: 3150000)
    ]
}
