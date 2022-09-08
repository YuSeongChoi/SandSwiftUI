//
//  ChefRecipesModel.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/31.
//

import Foundation

struct ChefRecipesModel {
  var recipes: [FoodRecipe] = load("Recipes.json")
  var nameSuggestions = [
    "Chicken Salad", "Blueberry Oatmeal", "Oatmeal Cookies", "Yorkshire Puds",
    "Acorn Squash Recipe", "Pizza", "Lentils and Rice", "Roasted Asparagus", "Roast"
  ]
  var ingredientSuggestions = [
    "🥩", "🐓", "🥗", "🍎", "🥚", "🥛", "🍋", "🧅", "🧈", "🫐",
    "🍚", "🧂", "🍬", "🌱", "🧃", "🧀", "🛢", "🥤", "🌰", "🍊", "💧"
  ]

  /// A function that loads a certain Decodable type by decoding a .json file given the name of the file in our project.
  /// - Returns: Instance of the same Decodable type the we use to decode the .json file.
  static func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
      fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
      data = try Data(contentsOf: file)
    } catch {
      fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
      let decoder = JSONDecoder()
      return try decoder.decode(T.self, from: data)
    } catch {
      fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
  }
}
