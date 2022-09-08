//
//  RecipeDetailView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/31.
//

import SwiftUI

struct RecipeDetailView: View {
    var recipe: FoodRecipe
    
    var body: some View {
        VStack(alignment: .center) {
            RecipeImage(imageURL: recipe.imageURL)
                .padding([.leading, .trailing])
            
            Text("Ingredients")
                .foregroundColor(Color("rw-dark"))
                .font(.largeTitle)
            
            List {
                ForEach(recipe.ingredients, id: \.self) { ingredient in
                    IngredientView(ingredient: ingredient)
                }
                .listStyle(.inset)
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(recipe.name)
                    .foregroundColor(Color("rw-dark"))
                    .fontWeight(.bold)
            }
        }
    }
}
