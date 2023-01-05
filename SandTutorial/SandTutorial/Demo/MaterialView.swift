//
//  MaterialView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/10/18.
//

import SwiftUI

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemUltraThinMaterialDark
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

struct MaterialView: View {

    private var materials: [Material] = [.ultraThinMaterial, .thinMaterial, .regularMaterial, .thickMaterial, .ultraThickMaterial]
    
    private var materialLabels: [String] = ["Ultra Thin Material", "Thin Material", "Regular Material", "Thick Material", "Ultra Thick Material"]
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            TabView {
                ForEach(0..<materials.count) { i in
                    ZStack {
                        Color(.clear)
                        Text(materialLabels[i])
                            .padding()
                            .foregroundColor(.secondary)
                    }
                    .background(materials[i]).cornerRadius(24)
                }
                .padding(.all, 10)
            }
            .frame(width: UIScreen.main.bounds.width, height: 200)
            .tabViewStyle(PageTabViewStyle())
        }
    }
    
}

struct MaterialView_Previews: PreviewProvider {
    static var previews: some View {
        MaterialView()
    }
}
