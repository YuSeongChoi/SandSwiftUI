//
//  PathMenu.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/10/18.
//

import SwiftUI

struct MenuItem2: View {
    
    let positions: [[CGFloat]] = [[0,0], [-110, -50], [-62, -90], [0, -110], [62, -90], [110, -50]]
    let icon: String
    var background: Color = Color.white
    var foreground: Color = Color.blue
    var size: CGFloat = 20
    var weight: Font.Weight = .regular
    var order: Int = 0
    var isActive: Bool = true
    
    var body: some View {
        Image(systemName: icon)
            .font(Font.system(size: size, weight: weight))
            .frame(width: 40, height: 40)
            .background(background)
            .cornerRadius(44)
            .rotationEffect(isActive ? .degrees(1080) : .zero)
            .animation(.spring(response: 0.4, dampingFraction: 0.75))
            .offset(x: isActive ? positions[order][0] : 0, y: isActive ? positions[order][1] : 0)
    }
    
}

struct PathMenu: View {
    
    @State private var isActive: Bool = true
    
    var body: some View {
        ZStack {
            Color("Beige")
                .edgesIgnoringSafeArea(.all)
            Color(.black)
                .opacity(isActive ? 0.5 : 0)
                .animation(.easeOut(duration: 0.2))
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                ZStack {
                    MenuItem2(icon: "music.note", foreground: Color.orange, order: 1, isActive: isActive)
                    MenuItem2(icon: "location.fill", foreground: Color.blue, order: 2, isActive: isActive)
                    MenuItem2(icon: "camera.fill", foreground: Color("Charcoal"), order: 3, isActive: isActive)
                    MenuItem2(icon: "quote.bubble.fill", foreground: Color.green, order: 4, isActive: isActive)
                    MenuItem2(icon: "moon.fill", foreground: Color.purple, order: 5, isActive: isActive)
                    MenuItem2(icon: "plus", background: Color.red, foreground: Color.white, size: 24, weight: .bold)
                        .overlay(
                            RoundedRectangle(cornerRadius: 44)
                                .stroke(Color.white, lineWidth: 2)
                        )
                        .rotationEffect(isActive ? .degrees(-225) : .zero)
                        .animation(.spring())
                        .onTapGesture(count: 1) {
//                            print("Tapped!")
                            isActive = !isActive
                        }
                }
            }.padding()
        }
    }
}

struct PathMenu_Previews: PreviewProvider {
    static var previews: some View {
        PathMenu()
    }
}
