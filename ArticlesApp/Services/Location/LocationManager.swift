//
//  LocationManager.swift
//  ArticlesApp
//
//  Created by Sebastian Maludziński on 18/02/2022.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    
    let locationManager = CLLocationManager()
    var completion: ((CLLocation) -> ())?
    
    public func getUserLocation(completion: @escaping (CLLocation) -> ()) {
        self.completion = completion
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        completion?(location)
        manager.stopUpdatingLocation()
    }
}
