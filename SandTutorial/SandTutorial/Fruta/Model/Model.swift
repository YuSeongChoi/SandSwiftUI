////
////  Model.swift
////  SandTutorial
////
////  Created by YuSeongChoi on 2022/08/29.
////
//
//import Foundation
//import AuthenticationServices
//import StoreKit
//
//class Model: ObservableObject {
//    @Published var order: Order?
//    @Published var account: Account?
//
//    var hasAccount: Bool {
//        #if targetEnvironment(simulator)
//        return true
//        #else
//        return userCredential != nil && account != nil
//        #endif
//    }
//
//    @Published var favoriteSmoothieIDs = Set<Smoothie.ID>()
//    @Published var selectedSmoothieID: Smoothie.ID?
//
//    @Published var searchString = ""
//
//    @Published var isApplePayEnabled = true
//    @Published var allRecipesUnlocked = false
//    @Published var unlockAllRecipesProduct: Product?
//
//    let
//}
