//
//  Thumbnail.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/10/14.
//

import SwiftUI

/// THis view shows a picture, that may be zoomed and cropped (insetted)
struct Thumbnail: View {
    
    @Environment(\.heroConfig) var config: HeroConfiguration
    
    let item: ItemData
    
    var body: some View {
        let w = config.thumbnailSize.width
        let h = config.thumbnailSize.height
        let s: CGFloat = 0.75 // makes the title a little smaller in the thumbnail
        
        return Color.clear.overlay(
            Image("\(item.id)")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: (w * config.thumbnailScalingFactor))
        )
        .overlay(TitleView3(item: item, scale: s), alignment: .topLeading)
        .clipShape(RoundedRectangle(cornerRadius: config.thumbnailRadius))
        .contentShape(RoundedRectangle(cornerRadius: config.thumbnailRadius))
        .frame(height: h)
    }
    
}
