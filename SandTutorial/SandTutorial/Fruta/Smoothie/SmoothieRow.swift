//
//  SmoothieRow.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/10/06.
//

import SwiftUI

struct SmoothieRow: View {
    
    var smoothie: Smoothie
    
    @EnvironmentObject private var model: Model
    
    var body: some View {
        HStack(alignment: .top) {
            let imageClipShape = RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            smoothie.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
                .clipShape(imageClipShape)
                .overlay(imageClipShape.strokeBorder(.quaternary, lineWidth: 0.5))
                .accessibility(hidden: true)
            
            VStack(alignment: .leading) {
                Text(smoothie.title)
                    .font(.headline)
                
                Text(listedIngredients)
                    .lineLimit(2)
                    .accessibility(label: Text("Ingredients: \(listedIngredients).", comment: "Accessibility label containing the full list of smoothie ingredients"))
                
                Text(smoothie.energy.formatted(.measurement(width: .wide, usage: .food)))
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }
            Spacer(minLength: 0)
        }
        .font(.subheadline)
        .accessibilityElement(children: .combine)
    }
    
    var listedIngredients: String {
        guard !smoothie.menuIngredients.isEmpty else { return "" }
        var list = [String]()
        list.append(smoothie.menuIngredients.first!.ingredient.name.localizedCapitalized)
        list += smoothie.menuIngredients.dropFirst().map { $0.ingredient.name.localizedLowercase }
        return ListFormatter.localizedString(byJoining: list)
    }
    
    var cornerRadius: Double {
        return 10
    }
    
}

