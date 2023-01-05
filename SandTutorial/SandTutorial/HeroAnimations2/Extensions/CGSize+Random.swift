//
//  CGSize+Random.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/10/17.
//

import SwiftUI

extension CGSize {
    static func random(width: ClosedRange<CGFloat>, height: ClosedRange<CGFloat>) -> CGSize {
        return CGSize(width: CGFloat.random(in: width), height: CGFloat.random(in: height))
    }
    
    static func random(in range: ClosedRange<CGFloat>) -> CGSize {
        return CGSize(width: CGFloat.random(in: range), height: CGFloat.random(in: range))
    }
}
