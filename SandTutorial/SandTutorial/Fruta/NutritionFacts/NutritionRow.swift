//
//  NutritionRow.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/10/06.
//

import SwiftUI

public struct NutritionRow: View {
    
    public var nutrition: Nutrition
    
    public init(nutrition: Nutrition) {
        self.nutrition = nutrition
    }
    
    var nutritionValue: String {
        nutrition.measurement.localizedSummary(
            unitStyle: .short,
            unitOptions: .providedUnit
        )
    }
    
    public var body: some View {
        HStack {
            Text(nutrition.name)
                .fontWeight(.medium)
            Spacer()
            Text(nutritionValue)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
        }
        .font(.footnote)
    }
    
}
