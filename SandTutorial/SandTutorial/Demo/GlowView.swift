//
//  GlowView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/10/18.
//

import SwiftUI

struct GlowView: View {
    
    @State private var playing = true
    
    var photo: some View = Image("shot")
        .resizable()
        .aspectRatio(contentMode: .fit)
    
    var body: some View {
        photo
            .cornerRadius(64)
            .blur(radius: 30)
            .offset(y: 10)
            .opacity(playing ? 0.9 : 0)
            .frame(width: playing ? 300 : 260)
            .overlay(photo.cornerRadius(12))
            .onTapGesture {
                playing.toggle()
            }
            .animation(.spring(response: 0.3, dampingFraction: 0.5))
    }
    
}

struct GlowView_Previews: PreviewProvider {
    static var previews: some View {
        GlowView()
    }
}
