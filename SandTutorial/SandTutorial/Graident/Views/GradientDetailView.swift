//
//  GradientDetailView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/09/16.
//

import SwiftUI

struct GradientDetailView: View {
    @Binding var gradient: GradientModel
    @State private var isEditing = false
    @State private var selectedStopID: Int?
    
    private var gradientBackground: some View {
        LinearGradient(gradient: gradient.gradient, startPoint: .leading, endPoint: .trailing)
            .ignoresSafeArea(edges: .bottom)
    }
    
    var body: some View {
        VStack {
            #if os(macOS)
            gradientBackground
            #else
            if !isEditing {
                gradientBackground
            } else {
                GradientControl(gradient: $gradient, selectedStopID: $selectedStopID)
                    .padding()
                
                if let selectedStopID = selectedStopID {
                    SystemColorList(color: $gradient[stopID: selectedStopID].color) {
                        gradient.remove(selectedStopID)
                        self.selectedStopID = nil
                    }
                } else {
                    SystemColorList.Empty()
                }
            }
            #endif
        }
        .safeAreaInset(edge: .bottom) {
            VStack(spacing: 0) {
                HStack {
                    if isEditing {
                        TextField("Name", text: $gradient.name)
                    } else {
                        gradient.name.isEmpty ? Text("New Gradient") : Text(gradient.name)
                    }
                    Spacer()
                    Text("\(gradient.stops.count) colors")
                        .foregroundStyle(.secondary)
                }
                .padding()
            }
            .background(.thinMaterial)
            .controlSize(.large)
        }
        .navigationTitle(gradient.name)
        .toolbar {
            Button(isEditing ? "Done" : "Edit") {
                isEditing.toggle()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
