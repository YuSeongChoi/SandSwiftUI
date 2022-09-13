//
//  ContentView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 15) {
                    HStack {
                        NavigationLink("Alba View") {
                            AlbaView()
                        }
                        NavigationLink("BulleyeView") {
                            BulleyeView()
                        }
                        NavigationLink("ReadMeView") {
                            ReadMeView()
                        }
                    }
                    HStack {
                        NavigationLink("MovieList") {
                            MovieList()
                        }
                        NavigationLink("SavanaTours") {
                            SavanaToursView()
                        }
                        NavigationLink("SpinnerView") {
                            SpinnerView()
                        }
                    }
                    HStack {
                        NavigationLink("NavigationMapView") {
                            InterestingPlacesView(places: MapDiretory().places)
                        }
                        NavigationLink("Asyquembine") {
                            Asyquembine()
                        }
                        NavigationLink("Buzzy") {
                            BuzzyView()
                        }
                    }
                    HStack {
                        NavigationLink("Draggable Map") {
                            DraggableMap()
                        }
                        NavigationLink("Chef Secrets") {
                            ChefSecretsView()
                        }
                        NavigationLink("My Tab View") {
                            MyTabView()
                        }
                    }
                    HStack {
                        NavigationLink("Taxi Map") {
                            TaxiView()
                        }
                    }
                }
            }
        }
    }
}
