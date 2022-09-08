//
//  Movie.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/25.
//

import Foundation

struct Movie: Codable {
    let title: String
    let genre: Genre
    let rating: Double
}

enum Genre: String, Codable, CaseIterable {
    case action = "Action"
    case adventure = "Adventure"
    case animation = "Animatinon"
    case crime = "Crime"
    case comedy = "Comedy"
    case drama = "Drama"
    case family = "Family"
    case horror = "Horror"
    case mystery = "Mystery"
    case romance = "Ramance"
    case scifi = "Sci-Fi"
    case thriller = "Thriller"
}
