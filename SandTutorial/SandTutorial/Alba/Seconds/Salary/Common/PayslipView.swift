//
//  PayslipView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2023/01/05.
//

import SwiftUI

struct PayslipView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    
    let selectedUserNumber: Int
    @Binding var emailToggle: Bool
    @Binding var smsToggle: Bool
    var onSubmit: @MainActor () -> ()
    
    private let borderColor = Color(red: 228/255, green: 228/255, blue: 228/255)
    
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
                HStack {
                    Text("선택 : ")
                    + Text("\(selectedUserNumber)").foregroundColor(.yellow)
                    + Text("명")
                }.font(.system(size: 20, weight: .bold))
                
                HStack(spacing: 10) {
                    Button {
                        // TODO: Email Toggle
                        emailToggle.toggle()
                    } label: {
                        Label {
                            Text("E-mail")
                                .foregroundColor(.black)
                        } icon: {
                            emailToggle ? Image(systemName: "checkmark.circle.fill").foregroundColor(.yellow) : Image(systemName: "circle").foregroundColor(borderColor)
                        }
                    }
                    .frame(maxWidth: .infinity, minHeight: 55, alignment: .leading)
                    .padding(.leading, 14)
                    .border(borderColor, width: 1)
                    
                    Button {
                        // TODO: SMS
                        smsToggle.toggle()
                    } label: {
                        Label {
                            Text("SMS")
                                .foregroundColor(.black)
                        } icon: {
                            smsToggle ? Image(systemName: "checkmark.circle.fill").foregroundColor(.yellow) : Image(systemName: "circle").foregroundColor(borderColor)
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
                    // TODO: 급여명세서 발송
                    onSubmit()
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
            .frame(maxWidth: .infinity)
            .padding([.top, .bottom], 40)
            .background(RoundedRectangle(cornerRadius: 15).fill(.white))
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
}
