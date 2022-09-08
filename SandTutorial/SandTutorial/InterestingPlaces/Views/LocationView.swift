//
//  LocationView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/26.
//

import SwiftUI

struct LocationView: View {
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        VStack {
            Spacer()
            Text(locationManager.locationString)
            Spacer()
            Button {
                locationManager.startLocationServices()
            } label: {
                Text("Start Location Services")
            }
        }
    }
}
