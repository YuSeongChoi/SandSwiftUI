//
//  SalaryInfoView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2023/01/09.
//

import SwiftUI

struct SalaryInfoView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    /// 총급여
    @State private var totalSalary: Int = 0
    /// 지급항목
    @State private var totalPayment: Int = 0
    
    // 과세
    /// 기본급
    @State private var basicSalary: Int = 0
    /// 연장근무수당
    @State private var overtiemSalary: Int = 0
    /// 야간근로수당
    @State private var nightSalary: Int = 0
    /// 휴일근로수당
    @State private var holidaySalary: Int = 0
    /// 주휴수당
    @State private var weeklySalary: Int = 0
    /// 상여
    
    // 비과세
    /// 식대비
    @State private var foodSubsidy: Int = 0
    /// 자가운전보조금
    @State private var driveSubsidy: Int = 0
    
    // 공제항목
    /// 소득세
    @State private var incomeTax: Int = 0
    /// 지방소득세
    @State private var localIncomeTax: Int = 0
    /// 국민연금
    @State private var peopleInsurance: Int = 0
    /// 건강보험
    @State private var healthInsurance: Int = 0
    /// 정기요양보험
    @State private var careInsurance: Int = 0
    /// 고용보험
    @State private var hireInsurance: Int = 0
    
    @State private var autoCalculateToggle: Bool = false
    
    private let decimalFormatter: NumberFormatter = {
       let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
            ScrollView(showsIndicators: false) {
                VStack(spacing: 30) {
                    // MARK: 직원정보
                    VStack(spacing: 13) {
                        HStack {
                            Text("한동숙")
                            Spacer()
                            Text("3.790.430 원")
                        }.font(.system(size: 24, weight: .bold))
                        HStack {
                            Text("8704300-1*")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                            Spacer()
                            Image("btnPayReset")
                        }
                    }.padding(.horizontal, 22)
                    dividerView
                    // MARK: 지급항목
                    paymentView()
                    dividerView
                    // MARK: 공제항목
                    deductionView()
                    HStack(spacing: 10) {
                        Button {
                            // TODO: 명세서 발송
                        } label: {
                            Rectangle()
                                .fill(.white)
                                .overlay(
                                    Text("명세서 발송")
                                        .foregroundColor(.yellow)
                                )
                                .border(.yellow, width: 1)
                        }
                        
                        Button  {
                            // TODO: 저장
                        } label: {
                            Rectangle()
                                .fill(.yellow)
                                .overlay(
                                    Text("저장")
                                        .foregroundColor(.white)
                                )
                                .border(.yellow, width: 1)
                        }
                        
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Rectangle()
                                .fill(Color(.systemGray4))
                                .overlay(
                                    Text("취소")
                                        .foregroundColor(.white)
                                )
                                .border(Color(.systemGray3), width: 1)
                        }
                    }
                    .frame(maxWidth: .infinity, idealHeight: 55)
                    .padding(.horizontal, 22)
                }.padding(.vertical, 30)
            }
        }
    }
    
    @ViewBuilder
    private func paymentView() -> some View {
        VStack(spacing: 20) {
            HStack {
                Text("지급항목").font(.system(size: 20, weight: .bold))
                Spacer()
                Text("4,500,000 원").font(.system(size: 17))
            }
            VStack(alignment: .center, spacing: 10) {
                Divider()
                Text("항목별 금액을 입력해주세요.")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                Line()
                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [3]))
                    .frame(height: 1)
                    .foregroundColor(.gray)
            }
            VStack(alignment: .leading, spacing: 20) {
                Text("과세").font(.system(size: 17, weight: .bold))
                HStack {
                    Text("기본급")
                    Spacer()
                    Text("4,500,000 원")
                }
                HStack {
                    Text("연장근무수당")
                    Spacer()
                    Text("0 원")
                }
                HStack {
                    Text("야간근로수당")
                    Spacer()
                    Text("0 원")
                }
                HStack {
                    Text("휴일근로수당")
                    Spacer()
                    Text("0 원")
                }
                HStack {
                    Text("주휴수당")
                    Spacer()
                    Text("0 원")
                }
                HStack {
                    Text("상여")
                    Spacer()
                    Text("0 원")
                }
            }.font(.system(size: 17))
            Divider()
            VStack(alignment: .leading, spacing: 20) {
                Text("비과세").font(.system(size: 17, weight: .bold))
                HStack {
                    Text("식대비")
                    Spacer()
                    Text("0 원")
                }
                HStack {
                    Text("자가운전보조금")
                    Spacer()
                    Text("0 원")
                }
            }.font(.system(size: 17))
        }.padding(.horizontal, 22)
    }
    
    @ViewBuilder
    private func deductionView() -> some View {
        VStack(spacing: 20) {
            HStack {
                Text("공제항목").font(.system(size: 20, weight: .bold))
                Label("자동계산", image: autoCalculateToggle ? "checkBoxOn" : "checkBox")
                    .onTapGesture {
                        autoCalculateToggle.toggle()
                    }
                    .font(.system(size: 14))
                Spacer()
                Text("709,570 원")
                    .font(.system(size: 17))
            }
            VStack(spacing: 10) {
                Divider()
                Text("항목을 직접 변경하시거나 자동 계산 버튼을 눌러 금액을 반영해주세요.")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                Line()
                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [3]))
                    .frame(height: 1)
                    .foregroundColor(.gray)
            }
            salaryInfoView(title: "소득세", money: 277840)
            salaryInfoView(title: "지방소득세", money: 27780)
            salaryInfoView(title: "국민연금", money: 202500)
            salaryInfoView(title: "건강보험", money: 150070)
            salaryInfoView(title: "장기요양보험", money: 15380)
            salaryInfoView(title: "고용보험", money: 36000)
        }.padding(.horizontal, 22)
    }
    
    @ViewBuilder
    private func salaryInfoView(title: String, money: Int) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(verbatim: "\(decimalFormatter.string(for: money) ?? "0") 원")
        }.font(.system(size: 17))
    }
    
    @ViewBuilder
    private var dividerView: some View {
        Text(" ")
            .frame(maxWidth: .infinity)
            .frame(height: 10)
            .background(Color(.systemGray5))
    }
    
}

// MARK: 점선
struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}
