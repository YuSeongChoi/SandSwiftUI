//
//  Booked.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/09/08.
//

import SwiftUI

struct Booked: View {
    @Binding var data: Data
    @Binding var doc: String
    @Binding var book: Bool
    
    var body: some View {
        GeometryReader { _ in
            VStack(spacing: 25) {
                Image(uiImage: UIImage(data: self.data)!)
                Button {
                    
                } label: {
                    Text("Cancel")
                        .foregroundColor(.white)
                        .padding(.vertical, 15)
                        .frame(width: UIScreen.main.bounds.width / 2)
                }
                .background(.red)
                .clipShape(Capsule())
            }
            .padding()
            .background(.white)
            .cornerRadius(12)
        }
        .background(Color.black.opacity(0.25).edgesIgnoringSafeArea(.all))
    }
}
