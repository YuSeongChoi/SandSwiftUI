//
//  RecipeList.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/10/06.
//

import SwiftUI

struct RecipeList: View {
    
    @EnvironmentObject private var model: Model
    
    var smoothies: [Smoothie] {
        Smoothie.all(includingPaid: model.allRecipesUnlocked)
            .filter { $0.matches(model.searchString) }
            .sorted { $0.title.localizedCompare($1.title) == .orderedAscending }
    }
    
    var body: some View {
        List {
            if !model.allRecipesUnlocked {
                Section {
                    unlockButton
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(EmptyView())
                        .listSectionSeparator(.hidden)
                        .listRowSeparator(.hidden)
                }
                .listSectionSeparator(.hidden)
            }
            ForEach(smoothies) { smoothie in
                NavigationLink(tag: smoothie.id, selection: $model.selectedSmoothieID) {
                    RecipeView(smoothie: smoothie)
                        .environmentObject(model)
                } label: {
                    SmoothieRow(smoothie: smoothie)
                        .padding(.vertical, 5)
                }

            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle(Text("Recipes", comment: "Title of the 'recipes' app section showing the list of. moothie recipes."))
        .animation(.spring(response: 1, dampingFraction: 1), value: model.allRecipesUnlocked)
        .accessibilityRotor("Favortie Smoothies", entries: smoothies.filter { model.isFavorite(smoothie: $0) }, entryLabel: \.title)
        .accessibilityRotor("Smoothies", entries: smoothies, entryLabel: \.title)
        .searchable(text: $model.searchString) {
            ForEach(model.searchSuggestions) { suggestion in
                Text(suggestion.name).searchCompletion(suggestion.name)
            }
        }
    }
    
    @ViewBuilder
    var unlockButton: some View {
        Group {
            if let product = model.unlockAllRecipesProduct {
                RecipeUnlockButton(
                    product: RecipeUnlockButton.Product(for: product),
                    purchaseAction: { model.purchase(product: product) }
                )
            } else {
                RecipeUnlockButton(
                    product: RecipeUnlockButton.Product(
                        title: "Unlock All Recipes",
                        description: "Loading...",
                        availability: .unavailable
                    ),
                    purchaseAction: {}
                )
            }
        }
        .transition(.scale.combined(with: .opacity))
    }
    
}
