//
//  AnimalImage.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/10/17.
//

import SwiftUI

struct AnimalImage: View {
    
    @Environment(\.gridRadiusPct) var radiusPercent: CGFloat
    @Environment(\.gridShadow) var shadowRadius: CGFloat
    
    let image: String
    let favorite: Bool
    
    var body: some View {
        Image(image)
            .resizable()
            .scaledToFill()
            .clipShape(RectangleToCircle(cornerRadiusPercent: radiusPercent))
            .shadow(radius: shadowRadius)
            .overlay(StarView(isFavorite: favorite), alignment: .topTrailing)
    }
    
}
