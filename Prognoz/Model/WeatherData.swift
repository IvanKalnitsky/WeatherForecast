//
//  WeatherData.swift
//  Prognoz
//
//  Created by macbookp on 20.06.2021.
//

import Foundation

struct WeatherData: Decodable {
    let info: Info
    let fact: Fact
    let forecasts: [Forecast]
    let geoObject: GeoObject
    
    enum CodingKeys: String, CodingKey {
            case info
            case geoObject = "geo_object"
            case fact
            case forecasts
        }
}

struct GeoObject: Decodable {
    let district, locality, province, country: Country
}

// MARK: - Country
struct Country: Decodable {
    let id: Int
    let name: String
}

struct Info: Decodable {
    let url: String
}

struct Fact: Decodable {
    let temp: Int
    let icon: String
    let condition: String
    let windSpeed: Double
    let pressureMm: Int
    
    enum CodingKeys: String, CodingKey {
            case temp
            case icon
            case condition
            case windSpeed = "wind_speed"
            case pressureMm = "pressure_mm"
        }
}

struct Forecast: Decodable {
    let parts: Parts
}

struct Parts: Decodable {
    let day: Hour
}

struct Hour: Decodable {
    let tempMin, tempMax: Int?
    
    enum CodingKeys: String, CodingKey {
            case tempMin = "temp_min"
            case tempMax = "temp_max"
        }
}
