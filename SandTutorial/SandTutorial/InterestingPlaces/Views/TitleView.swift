//
//  TitleView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/26.
//

import SwiftUI

struct TitleView: View {
    let locationName: String
    
    var body: some View {
        Text(locationName)
            .font(.largeTitle)
            .fontWeight(.heavy)
            .multilineTextAlignment(.center)
            .lineLimit(3)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .shadow(color: .black, radius: 1, x: 1, y: -2)
    }
}
