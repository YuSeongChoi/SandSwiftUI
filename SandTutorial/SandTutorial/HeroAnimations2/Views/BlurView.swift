//
//  BlurView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/10/17.
//

import SwiftUI

struct BlurView: View {
    
    @Environment(\.colorScheme) var scheme
    
    var active: Bool
    var onTap: () -> ()
    
    var body: some View {
        if active {
            VisualEffectView(uiVisualEffect: UIBlurEffect(style: scheme == .dark ? .dark : .light))
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    self.onTap()
                }
        }
    }
    
}
