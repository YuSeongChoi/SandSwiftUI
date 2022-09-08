//
//  RoadView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/26.
//

import SwiftUI

struct RoadView: View {
    
    var body: some View {
        ZStack {
            Color.gray
            
            Image("road")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .opacity(0.3)
        }
        .edgesIgnoringSafeArea(.all)
    }
    
}
