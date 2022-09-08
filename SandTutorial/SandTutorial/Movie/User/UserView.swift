//
//  UserView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/25.
//

import SwiftUI

struct UserView: View {
    @State private var userName = ""
    @State private var favoriteGenre = Genre.action
    @EnvironmentObject var userStore: UserStore
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("User")) {
                    TextField("User Name", text: $userName)
                }
                Section(header: Text("Favorite Genre")) {
                    GenrePicker(genre: $favoriteGenre)
                }
            }
        }
        .navigationBarTitle(Text("\(userName) Info"), displayMode: .inline)
        .navigationBarItems(
            trailing:
                Button(action: updateUserInfo) {
                    Text("Update")
                }
        )
        .onAppear {
            userName = userStore.currentUserInfo?.userName ?? ""
            favoriteGenre = userStore.currentUserInfo?.favoriteGenre ?? .action
        }
    }
    
    func updateUserInfo() {
        let newUserInfo = UserInfo(userName: userName, favoriteGenre: favoriteGenre)
        userStore.currentUserInfo = newUserInfo
        presentationMode.wrappedValue.dismiss()
    }
}
