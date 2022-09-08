//
//  SalaryView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/31.
//

import SwiftUI

struct SalaryView: View {
    @StateObject private var viewModel = SalaryViewModel()
    @State private var yearToggle: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            dateSelectionView()
            Divider()
            Text("월별 급여 내역")
                .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                .padding(EdgeInsets(top: 11, leading: 22, bottom: 10, trailing: 0))
                .background(Color(red: 248/255, green: 248/255, blue: 248/255))
                .font(.system(size: 13))
            
            ScrollView {
                LazyVStack(spacing : 0) {
                    ForEach(viewModel.months, id: \.self) { month in
                        NavigationLink {
                            SalaryDetailView(selectedDate: month)
                                .navigationTitle(Text("근태/급여"))
                        } label: {
                            VStack {
                                monthSalaryView(date: month)
                                Divider()
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.insertDefaultYears()
        }
    }
    
    @ViewBuilder
    private func dateSelectionView() -> some View {
        HStack {
            Button {
                viewModel.selectedYear = viewModel.selectedYear.addYear(n: -1)
                viewModel.insertDefaultMonths()
            } label: {
                Label(viewModel.dateToStringYear(date: viewModel.selectedYear.addYear(n: -1)), systemImage: "chevron.left")
            }.opacity(viewModel.limitMinimumYear() ? 0 : 1)
            Spacer()
            Button {
                yearToggle.toggle()
                viewModel.insertDefaultMonths()
            } label: {
                Text(viewModel.dateToStringYear(date: viewModel.selectedYear))
                Image(systemName: "chevron.down")
            }
            .fullScreenCover(isPresented: $yearToggle) {
                yearSelectionView()
                    .clearModalBackground()
                    .ignoresSafeArea()
            }
            Spacer()
            Button {
                viewModel.selectedYear = viewModel.selectedYear.addYear(n: 1)
                viewModel.insertDefaultMonths()
            } label: {
                Text(viewModel.dateToStringYear(date: viewModel.selectedYear.addYear(n: 1)))
                Image(systemName: "chevron.right")
            }.opacity(viewModel.limitMaximumYear() ? 0 : 1)
            
        }
        .foregroundColor(.black)
        .padding(EdgeInsets(top: 17, leading: 22, bottom: 19, trailing: 22))
    }
    
    @ViewBuilder
    private func yearSelectionView() -> some View {
        ZStack(alignment: .bottom) {
            Color.black
                .opacity(0.3)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    yearToggle.toggle()
                }
            
            VStack(alignment: .leading, spacing: 30) {
                Text("연도 선택")
                    .font(.system(size: 24, weight: .bold))
                    .padding([.top, .leading], 30)
                
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(viewModel.years, id: \.self) { year in
                        Button {
                            yearToggle.toggle()
                            viewModel.selectedYear = year
                            viewModel.insertDefaultMonths()
                        } label: {
                            HStack(spacing: 10) {
                                Text(viewModel.dateToStringYear(date: year))
                                    .font(.system(size: 19))
                                if viewModel.dateToStringYear(date: viewModel.selectedYear) == viewModel.dateToStringYear(date: year) {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.yellow)
                                }
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                        .padding([.leading, .bottom], 30)
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2, alignment: .leading)
            .background(RoundedRectangle(cornerRadius: 15).fill(.white))
        }
    }
    
    @ViewBuilder
    private func monthSalaryView(date: Date) -> some View {
        HStack {
            HStack {
                Text(viewModel.dateToStringMonth(date: date))
                    .foregroundColor(.black)
                Spacer()
            }
            VStack(spacing: 1) {
                HStack {
                    Text("총급여")
                    Spacer()
                    Text("0 원")
                }.foregroundColor(.black)
                HStack {
                    Text("공제액")
                    Spacer()
                    Text("0 원")
                }.foregroundColor(.black)
                HStack {
                    Text("지급액")
                        .foregroundColor(.yellow)
                    Spacer()
                    Text("0 원")
                        .foregroundColor(.black)
                }
            }
        }
        .padding(EdgeInsets(top: 20, leading: 22, bottom: 20, trailing: 22))
    }
}
