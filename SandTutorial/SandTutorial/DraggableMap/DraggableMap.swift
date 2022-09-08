//
//  DraggableMap.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/29.
//

import SwiftUI
import MapKit

struct DraggableMap: View {
    @State private var title = ""
    @State private var subtitle = ""
    
    var body: some View {
        ZStack(alignment: .bottom) {
            DraggableMapView(title: $title, subtitle: $subtitle).edgesIgnoringSafeArea(.all)
            
            HStack(spacing: 12) {
                Image(systemName: "info.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                
                VStack(alignment: .leading, spacing: 15) {
                    Text(title)
                        .font(.title)
                        .foregroundColor(.black)
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color(red: 0.942, green: 0.942, blue: 0.942))
                .cornerRadius(15)
            }
        }
    }
}

struct DraggableMapView: UIViewRepresentable {
    @Binding var title: String
    @Binding var subtitle: String
    
    func makeCoordinator() -> DraggableMapView.Coordinator {
        return DraggableMapView.Coordinator(parent: self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<DraggableMapView>) -> MKMapView {
        let map = MKMapView()
        let coorinate = CLLocationCoordinate2D(latitude: 37.4843, longitude: 126.8993)
        map.region = MKCoordinateRegion(center: coorinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coorinate
        map.delegate = context.coordinator
        map.addAnnotation(annotation)
        
        return map
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<DraggableMapView>) {
        
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
        var parent: DraggableMapView
        
        init(parent: DraggableMapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            pin.isDraggable = true
            pin.pinTintColor = .red
            pin.animatesDrop = true
            return pin
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
            guard let latitude = view.annotation?.coordinate.latitude, let longitude = view.annotation?.coordinate.longitude else { return }
            CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude)) { places, error in
                if error != nil {
                    print(error?.localizedDescription)
                    return
                }
                self.parent.title = places?.first?.name ?? ""
                self.parent.subtitle = places?.first?.locality ?? ""
            }
        }
    }
    
}
