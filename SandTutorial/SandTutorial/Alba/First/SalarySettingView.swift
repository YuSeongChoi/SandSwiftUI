//
//  SalarySettingView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/31.
//

import SwiftUI

struct SalarySettingView: View {
    enum WorktimeKind {
        case regularStart
        case regularEnd
        case nightStart
        case nightEnd
    }
    
    @StateObject private var viewModel = SalarySettingViewModel()
    
    @State private var paymentDayToggle: Bool = false
    @State private var paymentMonth: String = "당월지급"
    @State private var paymentDay: Int = 1
    @State private var hourPayment: String = ""
    
    @State private var startWorkToggle: Bool = false
    @State private var endWorkToggle: Bool = false
    @State private var startTime: Date = Date()
    @State private var endTime: Date = Date()
    
    @State private var breaktimeToggle: Bool = true
    @State private var restHolidayToggle: Bool = true
    
    @State private var nightStartWorkToggle: Bool = false
    @State private var nightEndWorkToggle: Bool = false
    @State private var nightStartTime: Date = Date()
    @State private var nightEndTime: Date = Date()
    @State private var nightPayPercent: String = ""
    
    @State private var overtimeInterval: String = ""
    @State private var overtimePercent: String = ""
    
    @State private var holidayPercent: String = ""
    
    private let months = ["당월지급", "차월지급"]
    private let days = [Int](1...31)
    
    private let timeFormater: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                paymentView()
                    .font(.system(size: 18, weight: .bold))
                workingHoursView()
                    .font(.system(size: 18, weight: .bold))
                horizontalToggleView()
                    .font(.system(size: 18, weight: .bold))
                nightPaymentView()
                    .font(.system(size: 16))
                overtimePaymentView()
                    .font(.system(size: 16))
                holidayPaymentView()
                    .font(.system(size: 18, weight: .bold))
            }
            .padding(.top, 30)
            .padding(.bottom, 60)
        }
        .onAppear {
            UIApplication.shared.hideKeyboard()
        }
    }
    
    @ViewBuilder
    private func paymentView() -> some View {
        VStack(spacing: 30) {
            VStack(spacing: 20) {
                HStack(spacing: 10) {
                    Text("급여일")
                    Spacer()
                    Button {
                        paymentDayToggle.toggle()
                    } label: {
                        Text("\(paymentMonth) \(paymentDay)일")
                            .foregroundColor(.black)
                        Image(systemName: "calendar.circle")
                            .foregroundColor(.yellow)
                    }
                    .fullScreenCover(isPresented: $paymentDayToggle) {
                        paymentPaymentDaySelectionView()
                            .clearModalBackground()
                            .ignoresSafeArea()
                    }
                }
                HStack(spacing: 10) {
                    Text("시급")
                    Spacer()
                    TextField("시급 입력", text: $hourPayment)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                        .font(.system(size: 16))
                        .frame(alignment: .trailing)
                    Text(" 원")
                    Image(systemName: "pencil")
                        .foregroundColor(.yellow)
                }
            }
            .padding([.leading, .trailing], 22)
            dividerView
        }
    }
    
    @ViewBuilder
    private func workingHoursView() -> some View {
        VStack(spacing: 30) {
            VStack(spacing: 20) {
                HStack(spacing: 10) {
                    Text("근무 시작시간")
                    Spacer()
                    Button {
                        startWorkToggle.toggle()
                    } label: {
                        Text(viewModel.workStartTime, formatter: timeFormater)
                            .foregroundColor(.black)
                        Image(systemName: "clock")
                            .foregroundColor(.yellow)
                    }
                    .fullScreenCover(isPresented: $startWorkToggle) {
                        workTimeSelectionView(timeToggle: $startWorkToggle, tag: .regularStart)
                            .clearModalBackground()
                            .ignoresSafeArea()
                    }
                }
                HStack(spacing: 10) {
                    Text("근무 종료시간")
                    Spacer()
                    Button {
                        endWorkToggle.toggle()
                    } label: {
                        Text(viewModel.workEndTime, formatter: timeFormater)
                            .foregroundColor(.black)
                        Image(systemName: "clock")
                            .foregroundColor(.yellow)
                    }
                    .fullScreenCover(isPresented: $endWorkToggle) {
                        workTimeSelectionView(timeToggle: $endWorkToggle, tag: .regularEnd)
                            .clearModalBackground()
                            .ignoresSafeArea()
                    }
                }
            }
            .padding([.leading, .trailing], 22)
            dividerView
        }
    }
    
    @ViewBuilder
    private func horizontalToggleView() -> some View {
        VStack(spacing: 30) {
            VStack(spacing: 20) {
                Toggle("휴게시간 자동적용", isOn: $breaktimeToggle)
                Toggle("주휴수당 자동적용", isOn: $restHolidayToggle)
            }
            .toggleStyle(SwitchToggleStyle(tint: .yellow))
            .padding([.leading, .trailing], 22)
            dividerView
        }
    }
    
    @ViewBuilder
    private func nightPaymentView() -> some View {
        VStack(spacing: 30) {
            VStack(alignment: .leading, spacing: 20) {
                Text("야간수당 (5인 이상)")
                    .font(.system(size: 18, weight: .bold))
                    .padding(.bottom, 5)
                HStack(spacing: 10) {
                    Text("근무 시작시간")
                    Spacer()
                    Button {
                        nightStartWorkToggle.toggle()
                    } label: {
                        Text(viewModel.nightWorkStartTime, formatter: timeFormater)
                            .foregroundColor(.black)
                        Image(systemName: "clock")
                            .foregroundColor(.yellow)
                    }
                    .fullScreenCover(isPresented: $nightStartWorkToggle) {
                        workTimeSelectionView(timeToggle: $nightStartWorkToggle, tag: .nightStart)
                            .clearModalBackground()
                            .ignoresSafeArea()
                    }
                }
                HStack(spacing: 10) {
                    Text("근무 종료시간")
                    Spacer()
                    Button {
                        nightEndWorkToggle.toggle()
                    } label: {
                        Text(viewModel.nightWorkEndTime, formatter: timeFormater)
                            .foregroundColor(.black)
                        Image(systemName: "clock")
                            .foregroundColor(.yellow)
                    }
                    .fullScreenCover(isPresented: $nightEndWorkToggle) {
                        workTimeSelectionView(timeToggle: $nightEndWorkToggle, tag: .nightEnd)
                            .clearModalBackground()
                            .ignoresSafeArea()
                    }
                }
                HStack(spacing: 10) {
                    Text("야간수당 배율")
                    Spacer()
                    HStack(spacing: 0) {
                        TextField("배율", text: $nightPayPercent)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .font(.system(size: 16))
                        Text(" %")
                    }
                    Image(systemName: "pencil")
                        .foregroundColor(.yellow)
                }
            }
            .padding([.leading, .trailing], 22)
            dividerView
        }
    }
    
    @ViewBuilder
    private func overtimePaymentView() -> some View {
        VStack(spacing: 30) {
            VStack(alignment: .leading, spacing: 20) {
                Text("연장근로수당 (5인 이상)")
                    .font(.system(size: 18, weight: .bold))
                    .padding(.bottom, 5)
                HStack(spacing: 10) {
                    Text("연장 수당 발생 시간")
                    Spacer()
                    TextField("연장 시간", text: $overtimeInterval)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                        .font(.system(size: 16))
                        .frame(width: 70)
                    Text("시간")
                    Image(systemName: "pencil")
                        .foregroundColor(.yellow)
                }
                HStack(spacing: 10) {
                    Text("연장 수당 배율")
                    Spacer()
                    HStack(spacing: 0) {
                        TextField("배율", text: $overtimePercent)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .font(.system(size: 16))
                        Text(" %")
                    }
                    Image(systemName: "pencil")
                        .foregroundColor(.yellow)
                }
            }
            .padding([.leading, .trailing], 22)
            dividerView
        }
    }
    
    @ViewBuilder
    private func holidayPaymentView() -> some View {
        HStack(spacing: 10) {
            Text("휴일(특근) 수당 배율")
            Spacer()
            HStack(spacing: 0) {
                TextField("배율", text: $holidayPercent)
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.trailing)
                    .font(.system(size: 16))
                    .frame(width: 70)
                Text(" %")
            }
            Image(systemName: "pencil")
                .foregroundColor(.yellow)
        }
        .padding([.leading, .trailing], 22)
    }
    
    @ViewBuilder
    private func horizontalText(title: String, content: String, imageName: String) -> some View {
        HStack(spacing: 10) {
            Text(title)
            Spacer()
            Text(content)
            Image(systemName: imageName)
                .foregroundColor(.yellow)
        }
        .padding([.leading, .trailing], 22)
    }
    
    @ViewBuilder
    private func paymentPaymentDaySelectionView() -> some View {
        ZStack(alignment: .bottom) {
            Color.black.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    paymentDayToggle.toggle()
                }
            VStack(spacing: 0) {
                ZStack {
                    Button {
                        paymentDayToggle.toggle()
                    } label: {
                        Text("확인")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, minHeight: 63)
                    }
                }
                .background(.yellow)
                
                HStack {
                    Picker(selection: $paymentMonth, label: Text("")) {
                        ForEach(months, id: \.self) { month in
                            Text("\(month)")
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(width: UIScreen.main.bounds.width / 2)
                    .compositingGroup()
                    .clipped()
                    
                    Picker(selection: $paymentDay, label: Text("")) {
                        ForEach(days, id: \.self) { day in
                            Text("\(day)일")
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(width: UIScreen.main.bounds.width / 2)
                    .compositingGroup()
                    .clipped()
                }
            }
            .background(.white)
        }
    }
    
    @ViewBuilder
    private func workTimeSelectionView(timeToggle: Binding<Bool>, tag: WorktimeKind) -> some View {
        ZStack(alignment: .bottom) {
            Color.black.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    timeToggle.wrappedValue.toggle()
                }
            
            VStack(spacing: 0) {
                ZStack {
                    Button {
                        timeToggle.wrappedValue.toggle()
                        if tag == .regularStart {
                            viewModel.workStartTime = startTime
                        } else {
                            viewModel.workEndTime = endTime
                        }
                        switch tag {
                        case .regularStart:
                            viewModel.workStartTime = startTime
                        case .regularEnd:
                            viewModel.workEndTime = endTime
                        case .nightStart:
                            viewModel.nightWorkStartTime = nightStartTime
                        case .nightEnd:
                            viewModel.nightWorkEndTime = nightEndTime
                        }
                    } label: {
                        Text("확인")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, minHeight: 63)
                    }
                }
                .background(.yellow)
                
                switch tag {
                case .regularStart:
                    DatePicker("", selection: $startTime, displayedComponents: .hourAndMinute)
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                case .regularEnd:
                    DatePicker("", selection: $endTime, displayedComponents: .hourAndMinute)
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                case .nightStart:
                    DatePicker("", selection: $nightStartTime, displayedComponents: .hourAndMinute)
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                case .nightEnd:
                    DatePicker("", selection: $nightEndTime, displayedComponents: .hourAndMinute)
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                }
            }
            .background(.white)
        }
    }
    
    @ViewBuilder
    private var dividerView: some View {
        Text("")
            .frame(width: UIScreen.main.bounds.width, height: 10)
            .background(Color.init(red: 248/255, green: 248/255, blue: 248/255))
    }
}
