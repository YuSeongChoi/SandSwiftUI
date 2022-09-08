//
//  MovieList.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/25.
//

import SwiftUI

struct MovieList: View {
    @EnvironmentObject var userStore: UserStore
    @StateObject var movieStore = MovieStore()
    @State private var isPresented = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(movieStore.movies, id: \.title) {
                    MovieRow(movie: $0)
                }
                .onDelete(perform: movieStore.deleteMovie)
            }
            .sheet(isPresented: $isPresented) {
                AddMovie(movieStore: movieStore, showModal: $isPresented)
            }
            .navigationBarTitle(Text("Fave Flicks"))
            .navigationBarItems(
                leading: NavigationLink(destination: UserView(), label: {
                    HStack {
                        userStore.currentUserInfo.map { Text($0.userName) }
                        Image(systemName: "person.fill")
                    }
                }),
                trailing: Button(action: { isPresented.toggle() }, label: {
                        Image(systemName: "plus")
                    }))
        }
    }
}
