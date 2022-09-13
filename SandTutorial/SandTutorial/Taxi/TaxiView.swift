//
//  TaxiView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/09/13.
//

import SwiftUI
import MapKit

struct TaxiView: View {
    @State private var map = MKMapView()
    @State private var manager = CLLocationManager()
    @State private var alert = false
    @State private var source: CLLocationCoordinate2D!
    @State private var destination: CLLocationCoordinate2D!
    @State private var txt = ""
    @State private var name = ""
    @State private var distance = ""
    @State private var time = ""
    @State private var show = false
    @State private var loading = false
    
    var body: some View {
        ZStack {
            ZStack(alignment: .bottom) {
                VStack(spacing: 0) {
                    HStack {
                        VStack(alignment: .leading, spacing: 15) {
                            Text(self.destination != nil ? "Destination" : "Pick a Location").font(.system(size: 23))
                            if self.destination != nil {
                                Text(self.name).font(.system(size: 23))
                            }
                        }
                        Spacer()
                    }
                    .padding()
                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                    .background(Color(.black).opacity(0.2))
                    
                    TaxiMapView(map: $map, manager: $manager, alert: $alert, source: $source, destination: $destination, txt: $txt, name: $name, time: $time, distance: $distance, show: $show)
                        .onAppear {
                            self.manager.requestAlwaysAuthorization()
                        }
                }
                
                if destination != nil && show {
                    ZStack(alignment: .topTrailing) {
                        VStack(spacing: 20) {
                            HStack {
                                VStack(alignment: .leading, spacing: 15) {
                                    Text("Destination").font(.system(size: 23))
                                    Text(name)
                                    Text("Distance - " + distance + " KM")
                                    Text("Expected Time" + time + " Min")
                                }
                                Spacer()
                            }
                            Button {
                                
                            } label: {
                                Text("Book now").foregroundColor(.white)
                                    .padding(.vertical, 10)
                                    .frame(width: UIScreen.main.bounds.width / 2)
                            }
                            .background(Color(#colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)))
                            .clipShape(Capsule())
                        }
                        Button {
                            self.map.removeOverlays(self.map.overlays)
                            self.map.removeAnnotations(self.map.annotations)
                            self.destination = nil
                            
                            self.show.toggle()
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                    .background(.white)
                }
            }
            if self.loading {
                Loader()
            }
        }
        .edgesIgnoringSafeArea(.all)
        .alert(isPresented: self.$alert) {
            Alert(title: Text("Error"), message: Text("Please Enable Location in Settings!"), dismissButton: .destructive(Text("OK")))
        }
    }
}
