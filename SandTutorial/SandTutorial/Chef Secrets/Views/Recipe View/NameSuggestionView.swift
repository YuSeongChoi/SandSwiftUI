//
//  NameSuggestionView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/31.
//

import SwiftUI

struct NameSuggestionView: View {
    var chefRecipesModel = ChefRecipesModel()
    
    var body: some View {
        ForEach(chefRecipesModel.nameSuggestions, id: \.self) { suggestion in
            Text(suggestion)
                .searchCompletion(suggestion)
        }
    }
}
