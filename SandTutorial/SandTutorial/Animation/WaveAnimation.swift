//
//  WaveAnimation.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/10/11.
//

import SwiftUI

struct WaveAnimation: View {
    
    @State private var scale1: CGFloat = 0
    @State private var scale2: CGFloat = 0
    @State private var scale3: CGFloat = 0
    
    var foreverAnimation = Animation.linear.speed(0.2).repeatForever(autoreverses: false)
    
    var body: some View {
        ZStack {
            Image(systemName: "circle.fill")
                .font(.system(size: 60))
                .foregroundColor(Color.white)
                .opacity(1 - scale1)
                .scaleEffect(1 + (scale1 * 2))
                .onAppear {
                    withAnimation(foreverAnimation) {
                        scale1 = 1
                    }
                }
            
            Image(systemName: "circle.fill")
                .font(.system(size: 60))
                .foregroundColor(.white)
                .opacity(1 - scale2)
                .scaleEffect(1 + (scale2 * 2))
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(foreverAnimation) {
                            scale2 = 1
                        }
                    }
                }
            
            Image(systemName: "circle.fill")
                .font(.system(size: 60))
                .foregroundColor(.white)
                .opacity(1 - scale3)
                .scaleEffect(1 + (scale3 * 2))
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        withAnimation(foreverAnimation) {
                            scale3 = 1
                        }
                    }
                }
            
            Image(systemName: "magnifyingglass")
                .frame(width: 60, height: 60, alignment: .center)
                .font(.system(size: 20))
                .foregroundColor(.black)
                .background(.white)
                .cornerRadius(30)
        }
    }
}

struct WaveAnimation_Previews: PreviewProvider {
    static var previews: some View {
        WaveAnimation()
    }
}
