//
//  FrutaView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/10/07.
//

import SwiftUI

struct FrutaView: View {
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    var body: some View {
        if horizontalSizeClass == .compact {
            AppTabNavigation()
        } else {
            AppSidebarNavigation()
        }
    }
    
}
