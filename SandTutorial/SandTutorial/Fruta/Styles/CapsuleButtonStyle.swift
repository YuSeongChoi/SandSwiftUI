//
//  CapsuleButtonStyle.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/26.
//

import SwiftUI

struct CapsuleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .dynamicTypeSize(.large)
            .padding(.horizontal, 15)
            .padding(.vertical, 8)
            .background(in: Capsule())
            .foregroundStyle(Color.accentColor)
            .contentShape(Capsule())
            .hoverEffect(.lift)
    }
}

extension ButtonStyle where Self == CapsuleButtonStyle {
    static var capsule: CapsuleButtonStyle {
        CapsuleButtonStyle()
    }
}
