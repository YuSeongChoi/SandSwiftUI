//
//  SalarySettingViewModel.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/09/01.
//

import SwiftUI

@MainActor
final class SalarySettingViewModel: ObservableObject, Identifiable {
    @Published var workStartTime: Date = Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: Date()) ?? Date()
    @Published var workEndTime: Date = Calendar.current.date(bySettingHour: 18, minute: 0, second: 0, of: Date()) ?? Date()
    @Published var nightWorkStartTime: Date = Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: Date()) ?? Date()
    @Published var nightWorkEndTime: Date = Calendar.current.date(bySettingHour: 18, minute: 0, second: 0, of: Date()) ?? Date()
}
