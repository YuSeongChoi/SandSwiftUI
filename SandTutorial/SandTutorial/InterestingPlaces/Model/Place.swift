//
//  Place.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/25.
//

import Foundation
import MapKit

final class Place: NSObject, Decodable, Identifiable {
    
    let name: String
    let image: String
    let sponsored: Bool
    let details: String
    let overlay: Bool
    let location: CLLocation
    private let regionRadius: CLLocationDistance = 1000
    let region: MKCoordinateRegion
    let id = UUID()
    
    init(from decoder: Decoder) throws {
        enum CodingKey: Swift.CodingKey {
            case name
            case image
            case sponsored
            case details
            case overlay
            case latitude
            case longitude
        }
        
        let values = try decoder.container(keyedBy: CodingKey.self)
        name = try values.decode(String.self, forKey: .name)
        image = try values.decode(String.self, forKey: .image)
        sponsored = try values.decode(Bool.self, forKey: .sponsored)
        details = try values.decode(String.self, forKey: .details)
        overlay = try values.decode(Bool.self, forKey: .overlay)
        let latitude = try values.decode(Double.self, forKey: .latitude)
        let longitude = try values.decode(Double.self, forKey: .longitude)
        location = CLLocation(latitude: latitude, longitude: longitude)
        region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
    }
    
}

extension Place: MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D { location.coordinate }
    var title: String? { name }
    
}
