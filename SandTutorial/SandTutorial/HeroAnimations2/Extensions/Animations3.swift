//
//  Animations.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/10/17.
//

import SwiftUI

//var debugAnimations = false

extension Animation {
    static var shake: Animation {
        if debugAnimations {
            return Animation.easeInOut(duration: 3.0)
        } else {
            return Animation.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.25)
        }
    }
    
    static var fly: Animation {
        if debugAnimations {
            return Animation.easeInOut(duration: 3.0)
        } else {
            return Animation.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.25)
        }
    }
    
    static var basic: Animation {
        if debugAnimations {
            return Animation.easeInOut(duration: 3.0)
        } else {
            return Animation.default
        }
    }
}
