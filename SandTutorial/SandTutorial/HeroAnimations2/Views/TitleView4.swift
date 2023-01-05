//
//  TitleView2.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/10/17.
//

import SwiftUI

struct TitleView4: View {
    
    @State private var slowAnimations: Bool = debugAnimations
    
    var body: some View {
        let debug = Binding<Bool> {
            slowAnimations
        } set: {
            slowAnimations = $0
            debugAnimations = $0
        }
        
        return VStack(alignment:.leading) {
            Text("Wildlife Encyclopedia")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            HStack {
                Text("Double tap to select favorites")
                    .font(.subheadline)
                    .foregroundColor(Color(UIColor.secondaryLabel))
                
                if debug.wrappedValue {
                    Text("Slow Animations On")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.horizontal, 5)
                        .background(Color.red)
                        .opacity(0.7)
                }
            }
            .onTapGesture {
                withAnimation {
                    debug.wrappedValue.toggle()
                }
            }
        }

    }
    
}
