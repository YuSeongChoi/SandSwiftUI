//
//  RecipeImage.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/31.
//

import SwiftUI

struct RecipeImage: View {
    var imageURL: String
    
    var body: some View {
        AsyncImage(url: URL(string: imageURL)) { image in
            image
                .resizable()
                .scaledToFit()
                .cornerRadius(8)
        } placeholder: {
            ZStack {
                Image("rw-logo")
                    .resizable()
                    .scaledToFit()
                ProgressView()
            }
        }
        .frame(maxWidth: .infinity)
    }
}
