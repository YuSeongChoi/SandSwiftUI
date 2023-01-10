//
//  YearMonthPickerView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2023/01/06.
//

import SwiftUI

struct YearMonthPickerView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @Binding var selectedDate: Date
    @State private var selectedYear: Int = 0
    @State private var selectedMonth: Int = 0
    
    private let years = [Int](Date().year - 100 ... Date().year + 100)
    private let months = [Int](1...12)
    
    var onClick: @MainActor () -> ()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
                .clearModalBackground()
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
            
            VStack(spacing: 0) {
                Button {
                    // TODO: 월 선택
                    selectedDate = makeDate(year: selectedYear, month: selectedMonth)
                    onClick()
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("확인")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 63)
                        .background(.yellow)
                }
                
                HStack {
                    Picker(selection: $selectedYear, label: Text("")) {
                        ForEach(years, id: \.self) { year in
                            Text(verbatim: "\(year)년")
                        }
                    }
                    
                    Picker(selection: $selectedMonth, label: Text("")) {
                        ForEach(months, id: \.self) { month in
                            Text("\(month)월")
                        }
                    }
                }
                .pickerStyle(.wheel)
            }
            .background(.white)
        }
        .onAppear {
            selectedYear = selectedDate.year
            selectedMonth = selectedDate.month
        }
    }
    
    private func makeDate(year: Int, month: Int) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM"
        return formatter.date(from: "\(year)-\(month)") ?? Date()
    }
    
}
