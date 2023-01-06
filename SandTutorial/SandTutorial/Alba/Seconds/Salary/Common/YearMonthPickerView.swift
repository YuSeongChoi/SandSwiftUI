//
//  YearMonthPickerView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2023/01/06.
//

import SwiftUI

struct YearMonthPickerView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @State private var selectedYear: Int = Date().year
    @State private var selectedMonth: Int = Date().month
    
    private let years = [Int](Date().year - 100 ... Date().year + 100)
    private let months = [Int](1...12)
    
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
                    .compositingGroup()
                    .clipped()
                    
                    Picker(selection: $selectedMonth, label: Text("")) {
                        ForEach(months, id: \.self) { month in
                            Text("\(month)월")
                        }
                    }
                    .compositingGroup()
                    .clipped()
                }
                .pickerStyle(.wheel)
            }
            .background(.white)
        }
    }
    
}

struct YearMonthPickerView_Previews: PreviewProvider {
    static var previews: some View {
        YearMonthPickerView()
    }
}
