//
//  GetCityWeatherService.swift
//  Test_Task_1
//
//  Created by Юрий Шелест on 18.12.22.
//

import Foundation
import CoreLocation

final class GetCityWeatherService {
    
    let networkService = NetworkService()
    
    func getCityWeather(citiesArray: [String], completion: @escaping (Int, Weather) -> Void ) {
        for (index, item) in citiesArray.enumerated() {
            getCoorditateFrom(city: item) { (coordinate, error) in
                guard let coordinate = coordinate, error == nil else { return }
                self.networkService.fetchWeather(latitude: coordinate.latitude, longitude: coordinate.longitude) { weather in
                    completion(index, weather)
                }
            }
        }
    }
    
    func getCoorditateFrom(city: String, compition: @escaping (_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        CLGeocoder().geocodeAddressString(city) { placemark, error in
            compition(placemark?.first?.location?.coordinate, error)
        }
    }
}
