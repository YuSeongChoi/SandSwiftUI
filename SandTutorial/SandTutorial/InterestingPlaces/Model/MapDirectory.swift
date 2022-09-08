//
//  MapDirectory.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/25.
//

import Foundation

struct MapDiretory {
    let places: [Place] = {
        guard let json = Bundle.main.url(forResource: "places", withExtension: ".json") else {
            fatalError("Unable to load json")
        }
        do {
            let jsonData = try Data(contentsOf: json)
            return try JSONDecoder().decode([Place].self, from: jsonData)
        } catch {
            fatalError("Unable to load or parse json file from bundle")
        }
    }()
}
