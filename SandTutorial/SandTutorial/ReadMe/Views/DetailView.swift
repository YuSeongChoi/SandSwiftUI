//
//  DetailView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/25.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var book: Book
    @EnvironmentObject var library: Library
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 16) {
                Button {
                    book.readMe.toggle()
                } label: {
                    Image(systemName: book.readMe ? "bookmark.fill" : "bookmark")
                        .font(.system(size: 48, weight: .light))
                }
                TitleAndAuthorStack(book: book, titleFont: .title, authorFont: .title2)
            }
            ReviewAndImageStack(book: book, image: $library.images[book])
        }
        .onDisappear {
            withAnimation {
                library.sortBooks()
            }
        }
        .padding()
    }
}
