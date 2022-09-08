//
//  SalaryDetailView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/09/02.
//

import SwiftUI

struct SalaryDetailView: View {
    @StateObject private var viewModel = SalaryViewModel()
    @State private var headerToggle: Bool = false
    @State private var paycheckToggle: Bool = false
    
    let selectedDate: Date
    let borderColor = Color(red: 228/255, green: 228/255, blue: 228/255)
    
    var body: some View {
        VStack(spacing : 0) {
            Divider()
            salaryHeaderView
            ScrollView {
                LazyVStack {
                    ForEach(0..<5) { _ in
                        monthCellView()
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
                headerToggle.toggle()
            } label: {
                Rectangle()
                    .fill(.white)
                    .border(.gray, width: 1)
                    .frame(width: 18, height: 18)
                    .overlay(
                        Image(systemName: "checkmark")
                            .foregroundColor(.yellow)
                            .opacity(headerToggle ? 1 : 0)
                    )
            }
            Text("\(viewModel.dateToStringMonth(date: selectedDate)) - 급여 상세")
                .font(.system(size: 13))
            Spacer()
        }
        .padding(EdgeInsets(top: 11, leading: 22, bottom: 11, trailing: 22))
        .background(Color(red: 244/255, green: 244/255, blue: 244/255))
    }
    
    @ViewBuilder
    private func monthCellView() -> some View {
        HStack {
            HStack(spacing: 10) {
                Rectangle()
                    .fill(.white)
                    .frame(width: 18, height: 18)
                    .border(.gray, width: 1)
                
                VStack(alignment: .leading, spacing: 3) {
                    Text("한동숙")
                        .font(.system(size: 17))
                    Text("890619-1*")
                        .font(.system(size: 13))
                }
                Spacer()
            }
            VStack(alignment: .leading) {
                HStack {
                    Text("총급여")
                    Spacer()
                    Text("3,600,000 원")
                }
                HStack {
                    Text("공제액")
                    Spacer()
                    Text("493,040 원")
                }
                HStack {
                    Text("지급액")
                        .foregroundColor(.yellow)
                    Spacer()
                        Text("3,106,960 원")
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
            }
            
            Button {
                
            } label: {
                Text("전월급여 복사")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 55)
                    .background(.yellow)
                    .border(.yellow, width: 1)
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
                    Text("발송")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 55)
                        .padding([.leading, .trailing], 22)
                        .background(.yellow)
                }
            }
            .frame(width: UIScreen.main.bounds.width)
            .padding([.top, .bottom], 30)
            .background(RoundedRectangle(cornerRadius: 15).fill(.white))
        }
    }
}

struct SalaryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SalaryDetailView(selectedDate: Date())
            .previewInterfaceOrientation(.portrait)
    }
}
