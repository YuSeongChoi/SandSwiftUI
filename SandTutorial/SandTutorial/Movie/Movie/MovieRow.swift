//
//  MovieRow.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/25.
//

import SwiftUI

struct MovieRow: View {
    let movie: Movie
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.title2)
                    .fontWeight(.light)
                Text(movie.genre.rawValue)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing) {
                RatingView(rating: movie.rating)
            }
        }
    }
}
