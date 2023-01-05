//
//  Animations.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/10/14.
//

import SwiftUI

// Use this variable to make all animations super slow, good for debugging transitions
var debugAnimations = false

extension Animation {
    static var hero: Animation { debugAnimations ? debug : .interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.25) }
    
    static var resetConfig: Animation { debugAnimations ? debug : .interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.25) }
    
    static var blur: Animation { debugAnimations ? debug: .linear(duration: 0.25) }
    
    static var debug: Animation { .easeInOut(duration: 4.0) }
}
