//
//  LoadingQuery.swift
//  SandTutorial
//
//  Created by YuSeongChoi on 2022/08/26.
//

import Foundation
import MapKit
import Combine

final class LocationQuery: ObservableObject {
    
    @Published var searchQuery = ""
    @Published private(set) var searchResults: [String] = []
    
    private var subscription: Set<AnyCancellable> = []
    private let region: MKCoordinateRegion
    
    init(region: MKCoordinateRegion) {
        self.region = region
        $searchQuery
            .debounce(for: .milliseconds(700), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink{ [weak self] value in
                let searchRequest = MKLocalSearch.Request()
                searchRequest.naturalLanguageQuery = value
                searchRequest.region = region
                let search = MKLocalSearch(request: searchRequest)
                search.start { response, error in
                    guard let response = response else {
                        if let error = error {
                            print(error.localizedDescription)
                        }
                        return
                    }
                    self?.searchResults = response.mapItems.compactMap(\.name)
                }
            }
            .store(in: &subscription)
    }
}
