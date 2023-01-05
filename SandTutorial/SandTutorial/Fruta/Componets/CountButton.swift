//
//  CountButton.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/10/06.
//

import SwiftUI

struct CountButton: View {
    
    @Environment(\.isEnabled) var isEnabled
    var mode: Mode
    var action: () -> Void
    
    public var body: some View {
        Button(action: action) {
            Image(systemName: mode.imageName)
                .symbolVariant(isEnabled ? .circle.fill : .circle)
                .imageScale(.large)
                .padding()
                .contentShape(Rectangle())
                .opacity(0.5)
        }
        .buttonStyle(.plain)
    }
    
}

extension CountButton {
    enum Mode {
        case increment
        case decrement
        
        var imageName: String {
            switch self {
            case .increment:
                return "plus"
            case .decrement:
                return "minus"
            }
        }
    }
}
