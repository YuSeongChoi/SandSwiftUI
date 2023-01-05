//
//  RecipeUnlockButton.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/10/06.
//

import SwiftUI
import StoreKit

struct RecipeUnlockButton: View {
    
    var product: Product
    var purchaseAction: () -> Void
    
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image("smoothie/recipes-background").resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 225)
                .accessibility(hidden: true)
            
            bottomBar
        }
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .strokeBorder(.quaternary, lineWidth: 0.5)
        }
        .accessibilityElement(children: .contain)
    }
    
    var bottomBar: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(product.title)
                    .font(.headline)
                    .bold()
                Text(product.description)
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
            }
            Spacer()
            if case let .available(displayPrice) = product.availability {
                Button(action: purchaseAction) {
                    Text(displayPrice)
                }
                .buttonStyle(.purchase)
                .accessibility(label: Text("Buy recipe for \(displayPrice)", comment: "Accessibility label for button to buy recipe for a certain price."))
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.regularMaterial)
        .accessibilityElement(children: .combine)
    }
    
}

extension RecipeUnlockButton {
    struct Product {
        var title: LocalizedStringKey
        var description: LocalizedStringKey
        var availability: Availability
    }
    
    enum Availability {
        case available(displayPrice: String)
        case unavailable
    }
}


extension RecipeUnlockButton.Product {
    init(for product: StoreKit.Product) {
        title = LocalizedStringKey(product.displayName)
        description = LocalizedStringKey(product.description)
        availability = .available(displayPrice: product.displayPrice)
    }
}
