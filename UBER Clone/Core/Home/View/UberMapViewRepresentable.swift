//
//  UberMapViewRepresentable.swift
//  UBER Clone
//
//  Created by Dalveer singh on 02/10/22.
//

import SwiftUI
import MapKit
struct UberMapViewRepresentable:UIViewRepresentable{
    let mapView = MKMapView()
    let locationManager = LocationManager.shared
    @Binding var mapState:MapViewState
    @EnvironmentObject var locationViewModel:LocationSearchViewModel
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
//        print("DEBUG : map state is \(mapState)")
        
        // to prevent the redrawing of line when the user clicks on back we introducted switch statement time 2:32:52
        switch mapState {
        case .noInput:
            context.coordinator.clearMapViewAndRecenterOnUserLocation()
        case .searchingForLocation:
            break
        case .locationSelected:
            if let coordinate = locationViewModel.selectedLocationCoordinate{
                context.coordinator.addAndSelectAnnotation(withCoordinate: coordinate)
                context.coordinator.configurePolyline(withDestinationCoordinate: coordinate)
            }
            break
        }
        
    }
    func makeCoordinator()->MapCoordinator{
        return MapCoordinator(parent:self)
    }
}
extension UberMapViewRepresentable{
    class MapCoordinator:NSObject,MKMapViewDelegate{
        
        
        //MARK: Properties
        let parent:UberMapViewRepresentable
        var userLocationCoordinate:CLLocationCoordinate2D?
        var currentRegion:MKCoordinateRegion?
        
        
        
        init(parent:UberMapViewRepresentable)
        {
            self.parent = parent
            super.init()
        }
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            self.userLocationCoordinate = userLocation.coordinate
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude),
                                            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            self.currentRegion = region
            parent.mapView.setRegion(region, animated: true)
        }
        
        
        
        func addAndSelectAnnotation(withCoordinate coordinate : CLLocationCoordinate2D)
        {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            parent.mapView.removeOverlays(parent.mapView.overlays)
            let anno = MKPointAnnotation()
            anno.coordinate = coordinate
            parent.mapView.addAnnotation(anno)
            parent.mapView.selectAnnotation(anno,animated:true)
//            parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
        }
        
        
        
        
        
        //MARK: - Generating route from source to destination
        
        // to render the overlay we need below function
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let line = MKPolylineRenderer(overlay: overlay)
            line.strokeColor = .systemBlue
            line.lineWidth = 6
            return line
        }
        
        
        // to create a ployline and to add overlay
        func configurePolyline(withDestinationCoordinate coordinate:CLLocationCoordinate2D){
            guard let userLocationCoordinate = self.userLocationCoordinate else {return}
            generateDestinationRoute(from: userLocationCoordinate, to:coordinate) { route in
               
                self.parent.mapView.addOverlay(route.polyline)
                let rect = self.parent.mapView.mapRectThatFits(route.polyline.boundingMapRect,edgePadding: .init(top: 64, left: 32, bottom: 500, right: 32))
                self.parent.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
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
                completion(route)
            }
        }
        func clearMapViewAndRecenterOnUserLocation(){
            parent.mapView.removeOverlays(parent.mapView.overlays)
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            if let currentRegion = currentRegion {
                parent.mapView.setRegion(currentRegion, animated: true)
            }
        }
    }
}
