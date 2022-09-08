//
//  UserStore.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/25.
//

import Combine

class UserStore: ObservableObject {
    @Published var currentUserInfo: UserInfo?
}
