//
//  SalaryDetailView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/09/02.
//

import SwiftUI

struct SalaryDetailView: View {
    
    @StateObject private var viewModel = SalaryViewModel()
    @State private var selectedMonth: Date = Date()
    
    @State private var headerToggle: Bool = false
    @State private var paycheckToggle: Bool = false
    @State private var copyPaymentToggle: Bool = false
    @State private var selectMonthToggle: Bool = false
    
    
    let selectedDate: Date
    let borderColor = Color(red: 228/255, green: 228/255, blue: 228/255)
    let decimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.positiveFormat = "#,##0 ¤"
        formatter.negativeFormat = "-#,##0 ¤"
        formatter.currencySymbol = "원"
        return formatter
    }()
    
    var body: some View {
        VStack(spacing : 0) {
            Divider()
            salaryHeaderView
            ScrollView {
                LazyVStack {
                    ForEach($viewModel.employeeList, id: \.self) { employee in
                        monthCellView(employee: employee)
                        Divider()
                    }
                }
            }
            bottomButtonView
        }
    }
    
    @ViewBuilder
    private var salaryHeaderView: some View {
        HStack(spacing: 12) {
            Button {
                selectAvaliableCells()
            } label: {
                if headerToggle {
                    Image(systemName: "checkmark.square.fill")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundColor(Color.yellow)
                } else {
                    Rectangle()
                        .fill(.white)
                        .frame(width: 18, height: 18)
                        .border(Color(uiColor: UIColor.systemGray5), width: 1)
                }
            }
            Text("\(viewModel.dateToStringMonth(date: selectedDate)) - 급여 상세")
                .font(.system(size: 13))
            Spacer()
        }
        .padding(EdgeInsets(top: 11, leading: 22, bottom: 11, trailing: 22))
        .background(Color(red: 244/255, green: 244/255, blue: 244/255))
    }
    
    private func selectAvaliableCells() {
        headerToggle.toggle()
        if headerToggle {
            $viewModel.employeeList.map(\.checkToggle).forEach{ $0.wrappedValue = true }
        } else {
            $viewModel.employeeList.map(\.checkToggle).forEach{ $0.wrappedValue = false }
        }
    }
    
    @ViewBuilder
    private func monthCellView(employee: Binding<EmployeeVO>) -> some View {
        HStack {
            HStack(spacing: 10) {
                if employee.wrappedValue.checkToggle {
                    Image(systemName: "checkmark.square.fill")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundColor(Color.yellow)
                } else {
                    Rectangle()
                        .fill(.white)
                        .frame(width: 18, height: 18)
                        .border(Color(uiColor: UIColor.systemGray5), width: 1)
                }
                
                VStack(alignment: .leading, spacing: 3) {
                    Text(employee.wrappedValue.name)
                        .font(.system(size: 17))
                    Text(employee.wrappedValue.registerNumber)
                        .font(.system(size: 13))
                }
                Spacer()
            }
            .onTapGesture {
                employee.wrappedValue.checkToggle.toggle()
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Text("총급여")
                    Spacer()
                    Text(decimalFormatter.string(from: employee.wrappedValue.totalSalary as NSNumber) ?? "0 원")
                }
                HStack {
                    Text("공제액")
                    Spacer()
                    Text(decimalFormatter.string(from: employee.wrappedValue.deductedAmount as NSNumber) ?? "0 원")
                }
                HStack {
                    Text("지급액")
                        .foregroundColor(.yellow)
                    Spacer()
                    Text(decimalFormatter.string(from: employee.wrappedValue.paymentAmount as NSNumber) ?? "0 원")
                }
            }
            .font(.system(size: 13))
            Text(Image(systemName: "chevron.right"))
                .frame(width: 24, height: 24)
                .foregroundColor(.gray)
        }
        .padding(EdgeInsets(top: 15, leading: 22, bottom: 15, trailing: 22))
    }
    
    @ViewBuilder
    private var bottomButtonView: some View {
        Divider()
        HStack(spacing: 11) {
            Button {
                paycheckToggle.toggle()
            } label: {
                Text("명세서 발송")
                    .foregroundColor(.yellow)
                    .frame(maxWidth: .infinity, minHeight: 55)
                    .background(.white)
                    .border(.yellow, width: 1)
            }
            .fullScreenCover(isPresented: $paycheckToggle) {
                paycheckView()
                    .clearModalBackground()
                    .ignoresSafeArea()
            }
            
            Button {
                copyPaymentToggle.toggle()
            } label: {
                Text("전월급여 복사")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 55)
                    .background(.yellow)
                    .border(.yellow, width: 1)
            }
            .fullScreenCover(isPresented: $copyPaymentToggle) {
                copyPaymentView()
                    .clearModalBackground()
                    .ignoresSafeArea()
            }
            
            Button {
                
            } label: {
                Text("근태자료 적용")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 55)
                    .background(.gray)
                    .border(.gray, width: 1)
            }
        }
        .font(.system(size: 14))
        .padding(EdgeInsets(top: 15, leading: 22, bottom: 30, trailing: 22))
    }
    
    @ViewBuilder
    private func paycheckView() -> some View {
        ZStack(alignment: .bottom) {
            Color.black
                .opacity(0.3)
                .edgesIgnoringSafeArea(.all)
                .clearModalBackground()
                .onTapGesture {
                    paycheckToggle.toggle()
                }
            
            VStack(spacing: 20) {
                HStack {
                    Text("선택 : ") +
                    Text("3").foregroundColor(.yellow) +
                    Text("명")
                }.font(.system(size: 20, weight: .bold))
                
                HStack(spacing: 10) {
                    Button {
                        
                    } label: {
                        Label {
                            Text("E-mail")
                                .foregroundColor(.black)
                        } icon: {
                            Image(systemName: "circle")
                                .foregroundColor(borderColor)
                        }
                    }
                    .frame(maxWidth: .infinity, minHeight: 55, alignment: .leading)
                    .padding(.leading, 14)
                    .border(borderColor, width: 1)
                    
                    Button {
                        
                    } label: {
                        Label {
                            Text("SMS")
                                .foregroundColor(.black)
                        } icon: {
                            Image(systemName: "circle")
                                .foregroundColor(borderColor)
                        }
                    }
                    .frame(maxWidth: .infinity, minHeight: 55, alignment: .leading)
                    .padding(.leading, 14)
                    .border(borderColor, width: 1)
                }
                .font(.system(size: 16))
                .padding([.leading, .trailing], 22)
                
                Text("급여명세서를 발송하시겠습니까?").font(.system(size: 16))
                
                Button {
                    
                } label: {
                    Rectangle()
                        .fill(Color.yellow)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .overlay(
                            Text("발송")
                                .foregroundColor(.white)
                                .font(.system(size: 17, weight: .medium))
                                .frame(alignment: .center)
                        )
                        .padding([.leading, .trailing], 22)
                }
            }
            .frame(width: UIScreen.main.bounds.width)
            .padding([.top, .bottom], 40)
            .background(RoundedRectangle(cornerRadius: 15).fill(.white))
        }
    }
    
    @ViewBuilder
    private func copyPaymentView() -> some View {
        ZStack(alignment: .bottom) {
            Color.black
                .opacity(0.3)
                .edgesIgnoringSafeArea(.all)
                .clearModalBackground()
                .onTapGesture {
                    copyPaymentToggle.toggle()
                }
            
            VStack(spacing: 20) {
                Text("선택한 월의 급여를 복사하시겠습니까?")
                    .font(.system(size: 17, weight: .regular))
                Text("* 급여 복사 시 전 직원의 급여가 복사됩니다.")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(.red)
                
                Button {
                    // TODO: 월 선택
                    selectMonthToggle.toggle()
                } label: {
                    Rectangle()
                        .fill(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .border(borderColor, width: 1)
                        .overlay(
                            Text("월 선택")
                                .foregroundColor(.black)
                                .font(.system(size: 20, weight: .bold))
                                .frame(alignment: .center)
                        )
                }
                .padding([.leading, .trailing], 22)
                .fullScreenCover(isPresented: $selectMonthToggle) {
                    monthSelectionView()
                }

                Button {
                    copyPaymentToggle.toggle()
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
                }.padding([.leading, .trailing], 22)
            }
            .frame(width: UIScreen.main.bounds.width)
            .padding([.top, .bottom], 40)
            .background(RoundedRectangle(cornerRadius: 15).fill(.white))
        }
    }
    
    @ViewBuilder
    private func monthSelectionView() -> some View {
        ZStack(alignment: .bottom) {
            Color.black
                .opacity(0.3)
                .edgesIgnoringSafeArea(.all)
                .clearModalBackground()
                .onTapGesture {
                    selectMonthToggle.toggle()
                }
            
            VStack(spacing: 0) {
                Button {
                    // TODO: 확인
                    selectMonthToggle.toggle()
                } label: {
                    Rectangle()
                        .fill(.yellow)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .overlay(
                            Text("확인")
                                .foregroundColor(.white)
                                .font(.system(size: 17, weight: .medium))
                                .frame(alignment: .center)
                        )
                }
                // TODO: DATEPICKER
                DatePicker("", selection: $selectedMonth, displayedComponents: .date)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .frame(maxWidth: .infinity, idealHeight: 200)
                    .background(.white)
            }
        }
        .clearModalBackground()
        .ignoresSafeArea()
    }
    
}

struct SalaryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SalaryDetailView(selectedDate: Date())
            .previewInterfaceOrientation(.portrait)
    }
}
