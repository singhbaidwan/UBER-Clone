//
//  LocationSearchViewModel.swift
//  UBER Clone
//
//  Created by Dalveer singh on 03/10/22.
//

import Foundation
import MapKit
class LocationSearchViewModel : NSObject,ObservableObject{
    
    @Published var results = [MKLocalSearchCompletion]()
    private let searchCompleter = MKLocalSearchCompleter()
    var queryFragment : String = ""{
        didSet{
//            print("DEBUG : Query fragment is \(queryFragment)")
            searchCompleter.queryFragment = queryFragment
        }
    }
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
}

extension LocationSearchViewModel : MKLocalSearchCompleterDelegate{
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
