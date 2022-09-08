//
//  ChefSecretsView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/31.
//

import SwiftUI

struct ChefSecretsView: View {
    @State private var searchQuery = ""
    @State private var isSearchingIngredient = false
    var chefRecipesModel = ChefRecipesModel()
    
    var body: some View {
        NavigationView {
            RecipesView(searchQuery: $searchQuery, isSearchingIngreident: $isSearchingIngredient)
            RecipeDetailView(recipe: chefRecipesModel.recipes[0])
        }
        .accentColor(Color("rw-green"))
        .searchable(text: $searchQuery, prompt: isSearchingIngredient ? "Search By Ingredient" : "Search By Meal Name") {
            if searchQuery.isEmpty {
                if isSearchingIngredient {
                    IngredientSuggestionView()
                } else {
                    NameSuggestionView()
                }
            }
        }
    }
}
