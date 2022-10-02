//
//  LocationManager.swift
//  UBER Clone
//
//  Created by Dalveer singh on 02/10/22.
//
import CoreLocation
class LocationManager:NSObject,ObservableObject{
    private let LocationManager = CLLocationManager()
    
    override init(){
        super.init()
        LocationManager.delegate = self
        LocationManager.desiredAccuracy = kCLLocationAccuracyBest
        LocationManager.requestWhenInUseAuthorization()
        LocationManager.startUpdatingLocation()
    }
    
}

extension LocationManager:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard locations.isEmpty else {return}
        LocationManager.stopUpdatingLocation()
    }
}
