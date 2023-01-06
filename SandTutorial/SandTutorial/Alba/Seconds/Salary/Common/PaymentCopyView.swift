//
//  PaymentCopyView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2023/01/05.
//

import SwiftUI

struct PaymentCopyView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @State private var selectedMonthToggle: Bool = false
    @State private var initDateToggle: Bool = false
    @State private var selectedDate: Date = Date()
    
    private let borderColor = Color(red: 228/255, green: 228/255, blue: 228/255)
    private let dateForamtter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월"
        return formatter
    }()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black
                .opacity(0.3)
                .edgesIgnoringSafeArea(.all)
                .clearModalBackground()
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
            
            VStack(spacing: 20) {
                VStack(spacing: 8) {
                    Text("선택한 월의 급여를 복사하시겠습니까?")
                        .font(.system(size: 17, weight: .regular))
                    Text("* 급여 복사 시 전 직원의 급여가 복사됩니다.")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(.red)
                }
                
                Button {
                    selectedMonthToggle.toggle()
                } label: {
                    Rectangle()
                        .fill(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .border(borderColor, width: 1)
                        .overlay(
                            HStack {
                                if initDateToggle {
                                    Text(dateForamtter.string(from: selectedDate))
                                        .foregroundColor(.black)
                                        .font(.system(size: 20, weight: .bold))
                                        .frame(alignment: .center)
                                } else {
                                    Text("월 선택")
                                        .foregroundColor(.black)
                                        .font(.system(size: 20, weight: .bold))
                                        .frame(alignment: .center)
                                }
                            }
                        )
                }
                .padding([.leading, .trailing], 22)
                .fullScreenCover(isPresented: $selectedMonthToggle) {
                    // TODO: YearMonth Picker
                    YearMonthPickerView(selectedDate: $selectedDate) { 
                        initDateToggle.toggle()
                    }
                        
                }
                
                Button {
                    // TODO: 급여 복사
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Rectangle()
                        .fill(.yellow)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .overlay(
                            Text("예")
                                .foregroundColor(.white)
                                .font(.system(size: 17, weight: .medium))
                                .frame(alignment: .center)
                        )
                }
                .padding(.horizontal, 22)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 50)
            .background(RoundedRectangle(cornerRadius: 15).fill(.white))
        }
        .ignoresSafeArea()
    }
    
}
