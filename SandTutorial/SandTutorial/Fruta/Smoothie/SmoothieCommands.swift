//
//  SmoothieCommands.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/10/06.
//

import SwiftUI

struct SmoothieCommands: Commands {
    
    let model: Model
    
    var body: some Commands {
        CommandMenu(Text("Smoothie", comment: "Menu title for smoothie-related actions")) {
            SmoothieFavoriteButton().environmentObject(model)
                .keyboardShortcut("+", modifiers: [.option, .command])
        }
    }
    
}
