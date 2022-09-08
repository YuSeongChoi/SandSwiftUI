//
//  IngredientSuggestionView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/31.
//

import SwiftUI

struct IngredientSuggestionView: View {
    var chefRecipesModel = ChefRecipesModel()
    
    var body: some View {
        ForEach(chefRecipesModel.ingredientSuggestions, id: \.self) { ingredient in
            Text(ingredient)
                .searchCompletion(ingredient)
                .padding()
                .font(.title)
        }
    }
}
