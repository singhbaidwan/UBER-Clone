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
        LocationManager.desiredAccuracy = kCLLocationAccuracyBest
        LocationManager.requestWhenInUseAuthorization()
        LocationManager.startUpdatingLocation()
    }
}

