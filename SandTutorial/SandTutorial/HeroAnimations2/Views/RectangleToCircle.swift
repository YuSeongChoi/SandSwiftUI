//
//  RectangleToCircle.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/10/17.
//

import SwiftUI

// This shapes creates a rounded rectangle, with a corner radius expressed as a percentage.
// Percent = 0.0 creates a rectange
// Percent = 1.0 creates a circle
struct RectangleToCircle: InsettableShape {
    
    var cornerRadiusPercent: CGFloat
    
    func path(in rect: CGRect) -> Path {
        Path(roundedRect: rect, cornerSize: CGSize(width: (rect.width / 2.0) * cornerRadiusPercent, height: (rect.height / 2.0) * cornerRadiusPercent))
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        return SquareToCircle_Inset(base: self, amount: amount)
    }
    
    struct SquareToCircle_Inset: InsettableShape {
        var base: RectangleToCircle
        var amount: CGFloat
        
        func path(in rect: CGRect) -> Path {
            RectangleToCircle(cornerRadiusPercent: base.cornerRadiusPercent).path(in: rect.insetBy(dx: amount, dy: amount))
        }
        
        func inset(by amount: CGFloat) -> some InsettableShape {
            var copy = self
            copy.amount += amount
            return copy
        }
    }
    
}
