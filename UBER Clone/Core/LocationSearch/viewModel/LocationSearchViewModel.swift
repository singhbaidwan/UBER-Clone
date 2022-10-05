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
    @Published var selectedUberLocation : UberLocation?
    @Published var pickUpTime:String?
    @Published var dropOffTime:String?
    var userLocation:CLLocationCoordinate2D?
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
    
    func selectedLocation(_ localSearch:MKLocalSearchCompletion)
    {
        locationSearch(forLocalSearchCompletion: localSearch) { response, error in
            if let error = error{
                print("DEBUG : Search Result failed with error \(error.localizedDescription)")
                return
            }
            guard let item = response?.mapItems.first else {return}
            let coordinate = item.placemark.coordinate
            self.selectedUberLocation = UberLocation(title: localSearch.title, coordinate: coordinate)
            print("DEBUG : selected location is \(coordinate)")
        }
    }
    func locationSearch(forLocalSearchCompletion localSearch : MKLocalSearchCompletion,completion: @escaping(MKLocalSearch.CompletionHandler))
    {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        search.start(completionHandler: completion)
    }
    func computeRidePrice(fortype type:RideType)->Double{
        guard let coordinate = selectedUberLocation?.coordinate else {return 0.0}
        guard let userLocation = userLocation else {
            return 0.0
        }
        
        let user = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        let destination = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let tripDistance = user.distance(from: destination)
        return type.computePrice(for: tripDistance)
    }
    // it will generate the route from user location entered to destination
    func generateDestinationRoute(from userLocation : CLLocationCoordinate2D,
                                  to destination:CLLocationCoordinate2D,
                                  completion: @escaping(MKRoute)->Void)
    {
        
        let userPlacemark = MKPlacemark(coordinate: userLocation)
        let destinationPlacemark = MKPlacemark(coordinate: destination)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: userPlacemark)
        request.destination = MKMapItem(placemark: destinationPlacemark)
        let direction = MKDirections(request: request)
        direction.calculate { response, error in
            if let error = error{
                print("DEBUG : failed to get the route from source to destination \(error.localizedDescription)")
                return
            }
            guard let route = response?.routes.first else {return }
            self.configurePickUpAndDropOffTime(with: route.expectedTravelTime)
            completion(route)
        }
    }
    func configurePickUpAndDropOffTime(with expectedTravelTime:Double){
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        pickUpTime = formatter.string(from: Date())
        dropOffTime = formatter.string(from: Date()+expectedTravelTime)
    }
}

extension LocationSearchViewModel : MKLocalSearchCompleterDelegate{
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
