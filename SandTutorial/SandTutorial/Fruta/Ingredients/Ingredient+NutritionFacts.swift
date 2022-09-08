//
//  Ingredient+NutritionFacts.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/29.
//

extension Ingredient {
    var nutritionFact: NutritionFact? {
        NutritionFact.lookupFoodItem(id, forVolume: .cups(1))
    }
}
