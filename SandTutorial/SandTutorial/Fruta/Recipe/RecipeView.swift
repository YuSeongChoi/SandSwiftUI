//
//  RecipeView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/10/06.
//

import SwiftUI

struct RecipeView: View {
    
    var smoothie: Smoothie
    @EnvironmentObject private var model: Model
    
    @State private var smoothieCount = 1
    
    var backgroundColor: Color {
        return Color(uiColor: .secondarySystemBackground)
    }
    
    let shape = RoundedRectangle(cornerRadius: 24, style: .continuous)
    
    var recipeToolbar: some View {
        StepperView(
            value: $smoothieCount,
            label: "\(smoothieCount) Smoothies",
            configuration: StepperView.Configuration(increment: 1, minValue: 1, maxValue: 9)
        )
        .frame(maxWidth: .infinity)
        .padding(20)
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
}

struct RecipeIngredientRow: View {
    
    var measuredIngredient: MeasuredIngredient
    
    @State private var checked = false
    
    var body: some View {
        Button(action: { checked.toggle() }) {
            HStack {
                measuredIngredient.ingredient.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .scaleEffect(measuredIngredient.ingredient.thumbnailCrop.scale * 1.25)
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(measuredIngredient.ingredient.name).font(.headline)
                    MeasurementView(measurement: measuredIngredient.measurement)
                }
                Spacer()
                Toggle(isOn: $checked) {
                    Text("Complete", comment: "Label for toggle showing wheter you have completed adding an ingredient that's part of a smoothie recipe")
                }
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .toggleStyle(.circle)
    }
    
}
