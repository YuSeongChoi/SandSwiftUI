//
//  SalaryListCalendarViewModel.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/10/28.
//

import Foundation

@MainActor
final class SalaryListCalendarViewModel: Identifiable, ObservableObject {
    
    @Published var selectedDate: Date = Date()
    let currentDate = Date()
    
}
