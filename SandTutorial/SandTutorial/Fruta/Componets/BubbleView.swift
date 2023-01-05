//
//  BubbleView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/10/07.
//

import SwiftUI

struct BubbleView: View {
    
    var size: Double = 30
    var xOffset: Double = 0
    var yOffset: Double = 0
    var opacity: Double = 0.1
    
    @State private var shimmer: Bool = .random()
    @State private var shimmerDelay: Double = .random(in: 0.15...0.55)
    
    @State private var float: Bool = .random()
    @State private var floatDelay: Double = .random(in: 0.15...0.55)
    
    var body: some View {
        Circle()
            .blendMode(.overlay)
            .opacity(shimmer ? opacity * 2 : opacity)
            .frame(width: size, height: size)
            .scaleEffect(shimmer ? 1.1 : 1)
            .offset(x: xOffset, y: yOffset)
            .offset(y: float ? 4 : 0)
    }
    
}
