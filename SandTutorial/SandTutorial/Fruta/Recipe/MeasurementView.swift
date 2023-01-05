//
//  MeasurementView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/10/06.
//

import SwiftUI

struct MeasurementView: View {
    
    var measurement: DisplayableMeasurement
    
    var body: some View {
        HStack {
            measurement.unitImage
                .foregroundStyle(.secondary)
            Text(measurement.localizedSummary())
        }
    }
    
}
