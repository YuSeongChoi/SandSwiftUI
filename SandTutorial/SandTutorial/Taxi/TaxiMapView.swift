//
//  TaxiMapView.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/09/08.
//

import SwiftUI
import CoreLocation
import MapKit

struct TaxiMapView: UIViewRepresentable {
    @Binding var map: MKMapView
    @Binding var manager: CLLocationManager
    @Binding var alert: Bool
    @Binding var source: CLLocationCoordinate2D
    @Binding var destination: CLLocationCoordinate2D?
    @Binding var txt: String
    @Binding var name: String
    @Binding var time: String
    @Binding var distance: String
    @Binding var show: Bool
    
    func makeUIView(context: Context) -> MKMapView {
        map.delegate = context.coordinator
        manager.delegate = context.coordinator
        map.showsUserLocation = true
        let gesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.Tap(ges:)))
        map.addGestureRecognizer(gesture)
        return map
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    func makeCoordinator() -> TaxiMapView.Coordinator {
        return TaxiMapView.Coordinator(parent1: self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate, CLLocationManagerDelegate {
        var parent: TaxiMapView
        
        init(parent1: TaxiMapView) {
            parent = parent1
        }
        
        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            if manager.authorizationStatus == .denied {
                self.parent.alert.toggle()
            } else {
                self.parent.manager.startUpdatingLocation()
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let region = MKCoordinateRegion(center: locations.last!.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            self.parent.source = locations.last!.coordinate
            self.parent.map.region = region
        }
        
        @objc func Tap(ges: UITapGestureRecognizer) {
            let location = ges.location(in: self.parent.map)
            print("LCK location : \(location)")
            let mplocation = self.parent.map.convert(location, toCoordinateFrom: self.parent.map)
            print("LCK mplocation : \(mplocation)")
            let point = MKPointAnnotation()
            point.title = "Source"
            point.subtitle = "Destination"
            
            let decoder = CLGeocoder()
            decoder.reverseGeocodeLocation(CLLocation(latitude: mplocation.latitude, longitude: mplocation.longitude)) { places, error in
                if error != nil {
                    print("LCK ERROR ! : \(error?.localizedDescription)")
                    return
                }
                self.parent.name = places?.first?.name ?? ""
                point.title = places?.first?.name ?? ""
                self.parent.show = true
            }
            print("LCK parent : \(parent)")
            let req = MKDirections.Request()
            req.source = MKMapItem(placemark: MKPlacemark(coordinate: self.parent.source))
            req.destination = MKMapItem(placemark: MKPlacemark(coordinate: mplocation))
            print("LCK req : \(req)")
            let direction = MKDirections(request: req)
            print("LCK direction : \(direction)")
            direction.calculate { dir, error in
                if error != nil {
                    print("LCK direction ERROR : \(error?.localizedDescription)")
                    return
                }
                
                let polyline = dir?.routes[0].polyline
                let dis = dir?.routes[0].distance as! Double
                self.parent.distance = String(format: "%.1f", dis / 1000)
                let time = dir?.routes[0].expectedTravelTime as! Double
                self.parent.distance = String(format: "%.1f", time / 60)
                self.parent.map.removeOverlays(self.parent.map.overlays)
                self.parent.map.addOverlay(polyline!)
                self.parent.map.setRegion(MKCoordinateRegion(polyline!.boundingMapRect), animated: true)
            }
            point.coordinate = mplocation
            self.parent.map.removeAnnotations(self.parent.map.annotations)
            self.parent.map.addAnnotation(point)
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let over = MKPolylineRenderer(overlay: overlay)
            over.strokeColor = .blue
            over.lineWidth = 3
            return over
        }
    }
}
