//
//  GetCitiestWeather.swift
//  Prognoz
//
//  Created by macbookp on 25.06.2021.
//

import Foundation
import CoreLocation

class WeatherManager {
    
    static let shared = WeatherManager()
    
    func getCitiesWeather(cityesArray: [String], completionHandler: @escaping([Weather]) -> Void) {
        var weathers = [Weather]()
        let group = DispatchGroup()
        for city in cityesArray {
            group.enter()
            getCoordinateFrom(city: city) { coordinate, error in
                guard let coordinate = coordinate, error == nil else { return }
                ApiManager.shared.fetchWeather(latitude: coordinate.latitude, longitude: coordinate.longitude) { cityWeather in
                    weathers.append(cityWeather)
                    group.leave()
                }
            }
        }
        group.notify(queue: .main) {
            completionHandler(weathers)
        }
    }
    
    func getCoordinateFrom(city: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?,_ error: Error?) -> ()) {
        CLGeocoder().geocodeAddressString(city) { placeMark, error in
            completion(placeMark?.first?.location?.coordinate, error)
        }
    }
}

