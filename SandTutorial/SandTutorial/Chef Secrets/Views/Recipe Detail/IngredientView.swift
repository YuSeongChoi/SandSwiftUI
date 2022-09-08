//
//  IngredientView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/31.
//

import SwiftUI

struct IngredientView: View {
    var ingredient: FoodIngredient
    
    var body: some View {
        HStack {
            Text(ingredient.name)
                .fontWeight(.bold)
            Spacer()
            Text(ingredient.quantity)
                .foregroundColor(Color("rw-green"))
        }
    }
}
