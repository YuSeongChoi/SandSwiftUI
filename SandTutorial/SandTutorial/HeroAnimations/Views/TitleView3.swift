//
//  TitleView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/10/14.
//

import SwiftUI

struct TitleView3: View {
    
    let item: ItemData
    let scale: CGFloat
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(item.tagLine)
                .font(.callout)
            
            Text(item.name)
                .font(.largeTitle)
                .fontWeight(.bold)
        }
        .padding(30)
        .background(
            LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .leading, endPoint: .trailing)
        )
        .foregroundColor(.white)
        .scaleEffect(scale, anchor: .topLeading)
    }
    
}
