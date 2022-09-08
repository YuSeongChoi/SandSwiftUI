//
//  LocationPhoto.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/26.
//

import SwiftUI

struct LocationPhoto: View {
    let photoName: String
    
    var body: some View {
        Image(photoName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxHeight: 200)
            .padding(10)
            .background(Color.white)
            .border(Color.black, width: 2)
            .shadow(radius: 30)
            .padding(.top)
            .rotationEffect(.degrees(.random(in: -5...5)), anchor: .center)
    }
}
