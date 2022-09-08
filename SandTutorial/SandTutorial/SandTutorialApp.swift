//
//  SandTutorialApp.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/25.
//

import SwiftUI

@main
struct SandTutorialApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Library())
                .environmentObject(UserStore())
        }
    }
    
    @MainActor
    init() {
        let barAppearance: UINavigationBarAppearance = {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithDefaultBackground()
            appearance.backgroundColor = .white
            appearance.backButtonAppearance.normal.titleTextAttributes[.foregroundColor] = UIColor.clear
            appearance.buttonAppearance.normal.titleTextAttributes[.font] = UIFont.boldSystemFont(ofSize: 17)
            let inset = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0)
            let newIndicator = appearance.backIndicatorImage.withAlignmentRectInsets(inset)
            let newTransition = appearance.backIndicatorTransitionMaskImage.withAlignmentRectInsets(inset)
            appearance.setBackIndicatorImage(newIndicator, transitionMaskImage: newTransition)
            return appearance
        }()
        let naviProxy = UINavigationBar.appearance(whenContainedInInstancesOf: [UINavigationController.self])
        naviProxy.standardAppearance = barAppearance
        naviProxy.barTintColor = .white
        naviProxy.tintColor = .black
    }
}
