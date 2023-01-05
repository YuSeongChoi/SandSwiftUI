//
//  FavoriteSmoothies.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/10/06.
//

import SwiftUI

struct FavoriteSmoothies: View {
    
    @EnvironmentObject private var model: Model
    
    var favoriteSmoothies: [Smoothie] {
        model.favoriteSmoothieIDs.map { Smoothie(for: $0)! }
    }
    
    var body: some View {
        SmoothieList(smoothies: favoriteSmoothies)
            .overlay {
                if model.favoriteSmoothieIDs.isEmpty {
                    Text("Add some smoothies to your favorites!", comment: "Placeholder text shown in list of smoothies when no favorite smoothies have been added yet")
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background()
                        .ignoresSafeArea()
                }
            }
            .navigationTitle(Text("Favorites", comment: "Title of the 'favorites' app section showing the list of favorite smoothies"))
            .environmentObject(model)
    }
    
}
