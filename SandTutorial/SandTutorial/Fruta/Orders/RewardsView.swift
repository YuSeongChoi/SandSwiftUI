//
//  RewardsView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/10/07.
//

import SwiftUI

struct RewardsView: View {
    
    @EnvironmentObject private var model: Model
    
    var body: some View {
        ZStack {
            RewardsCard(
                totalStamps: model.account?.unspentPoints ?? 0,
                animatedStamps: model.account?.unstampedPoints ?? 0,
                hasAccount: model.hasAccount
            )
            .onDisappear {
                model.clearUnstampedPoints()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarTitleDisplayMode(.inline)
        #if EXTENDED_ALL
        .safeAreaInset(edge: .bottom, spacing: 0) {
            VStack(spacing: 0) {
                Divider()
                if !model.hasAccount {
                    SignInWithAppleButton(.signUp, onRequest: { _ in }, onCompletion: model.authorizeUser)
                        .frame(minWidth: 100, maxWidth: 400)
                        .padding(.horizontal, 20)
                        .frame(height: 45)
                        .padding(.horizontal, 20)
                        .padding()
                        .frame(maxWidth: .infinity)
                }
            }
            .background(.bar)
        }
        #endif
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(BubbleBackground().ignoresSafeArea())
    }
    
}
