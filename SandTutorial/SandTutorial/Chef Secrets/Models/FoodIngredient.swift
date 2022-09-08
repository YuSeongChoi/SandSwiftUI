//
//  Ingredient.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/31.
//

import Foundation

struct FoodIngredient: Hashable, Codable {
    var quantity: String
    var name: String
    var type: String
    var emoji: String
}
