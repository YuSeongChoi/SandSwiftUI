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
    
    @State private var emailToggle: Bool = true
    @State private var smsToggle: Bool = false
    
    var selectedUserNumber: Int {
        get {
            let num = viewModel.employeeList.map(\.checkToggle).filter{ $0 == true }
            return num.count
        }
    }
    
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
        }.padding(.top, 1)
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
            
            VStack(alignment: .leading, spacing: 3) {
                HStack {
                    Text("총급여").foregroundColor(.gray)
                    Spacer()
                    Text(decimalFormatter.string(from: employee.wrappedValue.totalSalary as NSNumber) ?? "0 원")
                }
                HStack {
                    Text("공제액").foregroundColor(.gray)
                    Spacer()
                    Text(decimalFormatter.string(from: employee.wrappedValue.deductedAmount as NSNumber) ?? "0 원")
                }
                HStack {
                    Text("지급액").foregroundColor(.yellow)
                    Spacer()
                    Text(decimalFormatter.string(from: employee.wrappedValue.paymentAmount as NSNumber) ?? "0 원")
                }
            }
            .font(.system(size: 13))
            
            NavigationLink {
                SalaryInfoView()
            } label: {
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
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
                PayslipView(selectedUserNumber: selectedUserNumber, emailToggle: $emailToggle, smsToggle: $smsToggle) {
                    print("LCK SEND TOGGLE")
                }
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
                PaymentCopyView()
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
    
}

struct SalaryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SalaryDetailView(selectedDate: Date())
            .previewInterfaceOrientation(.portrait)
    }
}
