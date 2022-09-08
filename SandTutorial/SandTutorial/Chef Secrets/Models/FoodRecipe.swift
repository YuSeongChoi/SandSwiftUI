//
//  Recipe.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/31.
//

import Foundation

struct FoodRecipe: Hashable, Codable {
    var name: String
    var ingredients: [FoodIngredient]
    var steps: [String]
    var timers: [Int]
    var imageURL: String
}

