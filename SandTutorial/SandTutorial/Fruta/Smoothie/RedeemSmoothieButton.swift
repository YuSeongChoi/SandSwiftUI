//
//  RedeemSmoothieButton.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/10/06.
//

import SwiftUI

struct RedeemSmoothieButton: View {
    
    var action: () -> Void
    var height: Double {
        return 45
    }
    
    var body: some View {
        Button(action: action) {
            Text("Redeem Free Smoothie!", comment: "Button to redeem a free smoothie")
                .font(Font.headline.bold())
                .frame(height: height)
                .frame(minWidth: 100, maxWidth: 400)
                .foregroundStyle(.white)
                .background { Color.accentColor }
                .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                .contentShape(Rectangle())
        }
        .buttonStyle(.squishable)
    }
    
}
