//
//  RecipesView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/31.
//

import SwiftUI

struct RecipesView: View {
    @Environment(\.isSearching) var isSearching
    @Binding var searchQuery: String
    @Binding var isSearchingIngreident: Bool
    
    var chefRecipesModel = ChefRecipesModel()
    
    var filteredRecipes: [FoodRecipe] {
        if searchQuery.isEmpty {
            return chefRecipesModel.recipes
        } else {
            if isSearchingIngreident {
                let filteredRecipes = chefRecipesModel.recipes.filter {
                    !$0.ingredients.filter { ingredient in
                        ingredient.emoji == searchQuery
                    }.isEmpty
                }
                return filteredRecipes
            } else {
                return chefRecipesModel.recipes.filter {
                    $0.name.localizedCaseInsensitiveContains(searchQuery)
                }
            }
        }
    }
    
    var body: some View {
        VStack {
            Toggle("**Search By Ingredients**", isOn: $isSearchingIngreident)
                .tint(Color("rw-green"))
                .foregroundColor(Color("rw-green"))
                .font(.body)
                .padding([.leading, .trailing])
            if isSearching {
                Text("""
                  Search Results: \(filteredRecipes.count) \
                  of \(chefRecipesModel.recipes.count)
                  """)
                  .foregroundColor(Color("rw-green"))
                  .opacity(0.5)
            }
            List {
                ForEach(filteredRecipes, id: \.self) { recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                        Text(recipe.name)
                            .foregroundColor(Color("rw-dark"))
                    }
                }
            }
            .listStyle(.inset)
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Recipes")
                    .foregroundColor(Color("rw-dark"))
                    .font(.largeTitle)
                    .padding()
            }
        }
    }
}
