//
//  RewardsCard.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/10/07.
//

import SwiftUI

struct RewardsCard: View {
    
    var totalStamps: Int
    var animatedStamps = 0
    var hasAccount: Bool
    var compact = false
    
    var spacing: Double {
        compact ? 10 : 20
    }
    
    var columns: [GridItem] {
        [GridItem](repeating: GridItem(.flexible(minimum: 20), spacing: 10), count: 5)
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
}


extension RewardsCard {
    
    struct StampSlot: View {
        enum Status {
            case unstamped
            case stampedAnimated(delayIndex: Int)
            case stamped
        }
        
        var status: Status
        var compact = false
        
        @State private var stamped = false
        
        var body: some View {
            ZStack {
                Circle().fill(Color("bubbles-background").opacity(0.5))
                
                switch status {
                case .stamped, .stampedAnimated:
                    Image(systemName: "seal.fill")
                        .font(.system(size: compact ? 24 : 30))
                        .scaleEffect(stamped ? 1 : 2)
                        .opacity(stamped ? 1 : 0)
                        .foregroundStyle(Color("rewards-foreground"))
                default:
                    EmptyView()
                }
            }
            .aspectRatio(1, contentMode: .fit)
            .onAppear {
                switch status {
                case .stamped:
                    stamped = true
                case .stampedAnimated(let delayIndex):
                    let delay = Double(delayIndex + 1) * 0.15
                    stamped = true
                default:
                    stamped = false
                }
            }
        }
        
    }
    
}
