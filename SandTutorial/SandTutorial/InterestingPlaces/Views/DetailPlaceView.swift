//
//  DetailView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/26.
//

import SwiftUI

struct DetailPlaceView: View {
    private let location: Place
    @StateObject private var  snapshotter: Snapshotter
    
    var body: some View {
        VStack {
            TitleView(locationName: location.name)
            LocationPhoto(photoName: location.image)
            ScrollView {
                Text(location.details)
                    .font(.body)
                Image(uiImage: snapshotter.isOnDevice ? snapshotter.mapSnapShot! : snapshotter.defaultMap)
                    .resizable()
                    .frame(width: 200, height: 200)
                    .padding(.bottom)
            }
            .padding(.top)
        }
        .padding(.top, -60)
        .padding(.horizontal)
        .background(RoadView())
        .onAppear(perform: loadMapSnapshot)
    }
    
    init(location: Place) {
        self.location = location
        _snapshotter = StateObject(wrappedValue: Snapshotter(imageName: location.image, region: location.region))
    }
    
    func loadMapSnapshot() {
        if !snapshotter.isOnDevice {
            snapshotter.takeSnapshot()
        }
    }
    
}
