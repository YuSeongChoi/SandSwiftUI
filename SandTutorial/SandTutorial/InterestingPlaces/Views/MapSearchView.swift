//
//  MapSearchView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/26.
//

import SwiftUI
import MapKit

struct MapSearchView: View {
    @StateObject private var locationQuery: LocationQuery
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search", text: $locationQuery.searchQuery)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                List(locationQuery.searchResults, id: \.self, rowContent: Text.init)
            }
            .navigationTitle("Search")
        }
    }
    
    init(region: MKCoordinateRegion) {
        _locationQuery = StateObject(wrappedValue: LocationQuery(region: region))
    }
}
