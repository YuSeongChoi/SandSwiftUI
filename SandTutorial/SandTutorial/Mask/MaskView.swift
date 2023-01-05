//
//  MaskView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/10/04.
//

import SwiftUI

struct MaskView: View {
    var body: some View {
        VStack {
            starView()
                
            Image("dog-bark-park")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .mask(
                    ZStack {
                        Circle()
                            .frame(width: 200, height: 200)
                        Circle()
                            .frame(width: 90, height: 90)
                            .offset(x: 80, y: 55)
                    }
                )
                .frame(maxHeight: .infinity)
        }
    }
}

struct starView: View {
    @State private var rating: Int = 1
    
    var body: some View {
        ZStack {
            starsView
                .overlay(
                    overlayView
                        .mask(starsView)
                )
        }
    }
    
    private var overlayView: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.yellow)
                    .frame(minWidth: CGFloat(rating) / 5 * geo.size.width)
            }
        }
        .allowsHitTesting(false)
    }
    
    private var starsView: some View {
        HStack {
            ForEach(1..<6) { star in
                Image(systemName: "star.fill")
                    .foregroundColor(.gray)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            rating = star
                        }
                    }
            }
        }
    }
}

struct MaskView_Previews: PreviewProvider {
    static var previews: some View {
        MaskView()
    }
}
