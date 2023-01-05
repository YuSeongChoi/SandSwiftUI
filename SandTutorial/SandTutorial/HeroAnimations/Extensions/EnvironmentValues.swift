//
//  EnvironmentValues.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/10/14.
//

import SwiftUI

extension EnvironmentValues {
    var heroConfig: HeroConfiguration {
        get { return self[HeroConfigKey.self] }
        set { self[HeroConfigKey.self] = newValue }
    }
    
    var modalTransitionPercent: CGFloat {
        get { return self[ModalTransitionKey.self] }
        set { self[ModalTransitionKey.self] = newValue }
    }
}

public struct HeroConfigKey: EnvironmentKey {
    public static let defaultValue: HeroConfiguration = .default
}

public struct ModalTransitionKey: EnvironmentKey {
    public static let defaultValue: CGFloat = 0
}
