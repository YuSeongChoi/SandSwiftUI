//
//  TwinCircleAnimation.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/10/11.
//

import SwiftUI

struct TwinCircleAnimation: View {
    
    @State private var tz: CGFloat = 0
    @State private var color1 = Color.blue
    @State private var color2 = Color.blue
    
    var body: some View {
        ZStack {
            VStack{}
                .frame(width: 200, height: 200, alignment: .center)
                .background(Color.white)
                .cornerRadius(100)
            
            VStack{}
                .frame(width: 100, height: 100, alignment: .center)
                .background(color1)
                .scaleEffect(abs(tz) * 0.3 + 1)
                .offset(x: tz * 70, y: 0)
            
            VStack{}
                .frame(width: 100, height: 100, alignment: .center)
                .background(color2)
                .cornerRadius(50)
                .scaleEffect(abs(tz) * 0.3 + 1)
                .offset(x: -tz  * 70, y: 0)
        }
        .frame(width: 200, height: 200)
        .onAppear {
            animate()
        }
    }
    
    func animate() {
        withAnimation(.linear(duration: 0.15)) {
            tz = 1
            color1 = Color.cyan
            color2 = Color.green
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            withAnimation(.linear(duration: 0.3)) {
                tz = -1
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
            withAnimation(.easeOut(duration: 1.0)) {
                tz = 0
                color1 = Color.blue
                color2 = Color.blue
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.55) {
            animate()
        }
    }
    
}

struct TwinCircleAnimation_Previews: PreviewProvider {
    static var previews: some View {
        TwinCircleAnimation()
    }
}
