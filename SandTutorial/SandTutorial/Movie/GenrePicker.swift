//
//  GenrePicker.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/25.
//

import SwiftUI

struct GenrePicker: View {
    @Binding var genre: Genre
    
    var body: some View {
        Picker(selection: $genre, label: Spacer()) {
            ForEach(Genre.allCases, id: \.self) {
                Text($0.rawValue)
            }
        }
        .pickerStyle(WheelPickerStyle())
    }
}
