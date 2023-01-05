//
//  DataItems.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/10/17.
//

import SwiftUI

struct ItemData2: Identifiable {
    let id: Int
    let name: String
    let image: String
    let author: String
    let `class`: String
}

class DataModel: ObservableObject {
    @Published var items = [
        ItemData2(id: 1, name: "Elephant", image: "elephant", author: "Mylon Ollila", class: "Mammal"),
        ItemData2(id: 2, name: "Cheetah", image: "cheetah", author: "Jean Wimmerlin", class: "Mammal"),
        ItemData2(id: 3, name: "Parrot", image: "parrot", author: "Andrew Pons", class: "Aves"),
        ItemData2(id: 4, name: "Tiger", image: "tiger", author: "Mike Marrah", class: "Mammal"),
        ItemData2(id: 5, name: "Zebra", image: "zebra", author: "Frida Bredesen", class: "Mammal"),
        ItemData2(id: 6, name: "Lion", image: "lion", author: "Kazuky Akayashi", class: "Mammal"),
        ItemData2(id: 7, name: "Mandarin Fish", image: "mandarin-fish", author: "Dorothea Oldani", class: "Actinopterygii"),
        ItemData2(id: 8, name: "Apes", image: "ape", author: "Rob Schreckhise", class: "Mammal"),
        ItemData2(id: 9, name: "Peacock", image: "peacock", author: "Zuzanna J", class: "Aves"),
        ItemData2(id: 10, name: "Giraffe", image: "giraffe", author: "Charl Durand", class: "Mammal"),
        ItemData2(id: 11, name: "Fox", image: "fox", author: "Alexander Andrews", class: "Mammal"),
        ItemData2(id: 12, name: "Parrot Couple", image: "parrot-couple", author: "Roi Dimor", class: "Aves"),
        ItemData2(id: 14, name: "Polar Bear", image: "polar-bear", author: "Hans Jurgen Mager", class: "Mammal"),
        ItemData2(id: 15, name: "Dolphin", image: "dolphin", author: "Adam Berkecz", class: "Mammal"),
        ItemData2(id: 16, name: "Raccoon", image: "raccoon", author: "Gary Bendig", class: "Mammal"),
        ItemData2(id: 18, name: "Panda Bear", image: "panda-bear", author: "Sid Balachandran", class: "Mammal"),
        ItemData2(id: 17, name: "Penguin", image: "penguin", author: "Jay Ruzesky", class: "Aves"),
        ItemData2(id: 13, name: "Goldfish", image: "goldfish", author: "Zhengtao Tang", class: "Actinopterygii"),
    ]
    
    @Published var favorites: [ItemData2] = []
    
    func isFavorite(_ item: ItemData2) -> Bool {
        favorites.contains { $0.id == item.id }
    }
}
