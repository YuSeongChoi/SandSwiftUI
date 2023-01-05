//
//  StarView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/10/17.
//

import SwiftUI

struct StarView: View {
    
    let isFavorite: Bool
    
    var body: some View {
        if isFavorite {
            Image(systemName: "star.fill")
                .shadow(radius: 3)
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding(20)
        }
    }
    
}
