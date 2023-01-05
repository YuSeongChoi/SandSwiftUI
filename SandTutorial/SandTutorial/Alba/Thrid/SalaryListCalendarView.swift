//
//  SalaryListCalendarView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/31.
//

import SwiftUI

struct SalaryListCalendarView: View {
    
    @Environment(\.calendar) private var calendar
    @StateObject private var viewModel = SalaryListCalendarViewModel()
    
    private var hideNextButton:Bool {
        calendar.isDate(viewModel.selectedDate, equalTo: Date(), toGranularity: .month) || viewModel.selectedDate >= viewModel.currentDate
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header View
            Divider()
            topDateSelectionView()
            dividerView
            // Middle View
            paymentInfoView()
            // Bottom View
            dividerView
//            bottomListView()
            CalendarView(selectedDate: $viewModel.selectedDate)
        }
        
    }
    
    @ViewBuilder
    private var dividerView: some View {
        Text(" ")
            .frame(maxWidth: .infinity)
            .frame(height: 10)
            .background(Color(uiColor: .systemGray5))
    }
    
    @ViewBuilder
    private func topDateSelectionView() -> some View {
        HStack(alignment: .bottom) {
            Button {
                if let newDate = calendar.date(byAdding: .month, value: -1, to: viewModel.selectedDate) {
                    viewModel.selectedDate = newDate
                }
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3).foregroundColor(.black)
                    .padding(2).padding(.leading, 2).border(.gray)
            }.frame(alignment: .bottomLeading)
            Spacer()
            VStack {
                Text(calendar.component(.year, from: viewModel.selectedDate).description)
                    .font(.system(size: 10, weight: .regular))
                    .foregroundColor(.gray)
                Text("\(calendar.component(.month, from: viewModel.selectedDate)) 월")
                    .font(.system(size: 22, weight: .bold))
            }
            Spacer()
            if hideNextButton {
                Button {
                    if let newDate = calendar.date(byAdding: .month, value: 1, to: viewModel.selectedDate) {
                        viewModel.selectedDate = newDate
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title3)
                        .padding(2).border(.gray)
                }.frame(alignment: .bottomTrailing).hidden()
            } else {
                Button {
                    if let newDate = calendar.date(byAdding: .month, value: 1, to: viewModel.selectedDate) {
                        viewModel.selectedDate = newDate
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title3).foregroundColor(.black)
                        .padding(2).padding(.trailing, 2).border(.gray)
                }.frame(alignment: .bottomTrailing)
            }
        }
        .padding(EdgeInsets(top: 10, leading: 22, bottom: 10, trailing: 22))
    }
    
    @ViewBuilder
    private func paymentInfoView() -> some View {
        VStack(spacing: 20) {
            HStack {
                Text("한동숙")
                    .font(.system(size: 24, weight: .bold))
                Text("시급 8,350원")
                    .font(.system(size: 16, weight: .regular))
                Button {
                    // MARK: 시급 수정
                } label: {
                    Text(Image(systemName: "pencil"))
                        .font(.system(size: 16))
                        .foregroundColor(.yellow)
                }
                Spacer()
                Button {
                    // MARK: 일정 수정
                } label: {
                    Text(Image(systemName: "list.bullet"))
                        .font(.system(size: 24))
                        .foregroundColor(.yellow)
                }
            }
            HStack {
                Text("근로수당")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                Spacer()
                Text("180,350 원")
                    .font(.system(size: 16, weight: .bold))
            }
            HStack {
                Label {
                    Text("주휴수당")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                } icon: {
                    Image(systemName: "checkmark.square")
                        .foregroundColor(.gray)
                }
                Spacer()
                Text("25,156 원")
                    .font(.system(size: 16, weight: .bold))
            }
            Divider()
            HStack {
                Text("급여합계")
                    .font(.system(size: 18))
                Text("10시간 30분")
                    .font(.system(size: 12))
                Spacer()
                Text("3,215,416 원")
                    .font(.system(size: 18))
                Button {
                    // TODO: 급여합계
                } label: {
                    Text(Image(systemName: "chevron.right"))
                        .font(.system(size: 18))
                        .foregroundColor(Color(.systemGray3))
                }
            }
        }
        .padding(EdgeInsets(top: 15, leading: 22, bottom: 15, trailing: 22))
    }
    
    @ViewBuilder
    private func bottomListView() -> some View {
        List {
            ForEach(1..<10) { _ in
                HStack {
                    Text("01 금")
                    Spacer()
                    Text("5시간 5분")
                    Spacer()
                    Text("17:25 ~ 22:25")
                    Text(Image(systemName: "pencil"))
                        .font(.system(size: 16))
                        .foregroundColor(.yellow)
                }
            }
            .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
        }
        .listStyle(.plain)
        .padding(.bottom, 1)
    }
    
}

struct SalaryListCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        SalaryListCalendarView()
    }
}
