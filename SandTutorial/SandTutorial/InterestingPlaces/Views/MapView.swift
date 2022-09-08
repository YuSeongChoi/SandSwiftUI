//
//  MapView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/26.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    let location: Place
    let places: [Place]
    
    @State private var region: MKCoordinateRegion
    @State private var mapType: MKMapType = .standard
    @State private var showSearch = false
    @Environment(\.presentationMode) private var presentationMode
    
    init(location: Place, places: [Place]) {
        self.location = location
        self.places = places
        _region = State(initialValue: location.region)
    }

    var body: some View {
        ZStack {
            MapViewUI(location: location, places: places, mapViewType: mapType)
            VStack {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .imageScale(.large)
                    }
                    Spacer()
                    Button {
                        showSearch.toggle()
                    } label: {
                        Image(systemName: "magnifyingglass.circle.fill")
                            .imageScale(.large)
                    }
                }
                .padding()
                Spacer()
                Picker("", selection: $mapType) {
                    Text("Standard").tag(MKMapType.standard)
                    Text("Hybrid").tag(MKMapType.hybrid)
                    Text("Satellite").tag(MKMapType.satellite)
                }
                .pickerStyle(SegmentedPickerStyle())
                .offset(y: -20)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
        .sheet(isPresented: $showSearch) {
            MapSearchView(region: region)
        }
    }
}
