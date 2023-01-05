//
//  Visualizer.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/09/16.
//

import SwiftUI

struct Visualizer: View {
    var gradients: [Gradient]
    
    var body: some View {
        List {
            NavigationLink(destination: ShapeVisualizer(gradients: gradients).ignoresSafeArea()) {
                Label("Shapes", systemImage: "star.fill")
            }
            
            NavigationLink(destination: ParticleVisualizer(gradients: gradients).ignoresSafeArea()) {
                Label("Particles", systemImage: "sparkles")
            }
        }
        .navigationTitle("Visualizers")
    }
}
