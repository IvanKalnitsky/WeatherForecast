//
//  Weather.swift
//  Prognoz
//
//  Created by macbookp on 20.06.2021.
//

import Foundation

struct Weather {
    var name: String = "Название"
    var temperature: Int
    var conditionCode: String
    var url: String
    var condition: String
    var pressure: Int
    var windSpeed: Double
    var tempMin: Int
    var tempMax: Int
    
    var conditionString: String {
        switch condition {
        case "clear" : return "Ясно"
        case "partly-cloudy" : return "Малооблачно"
        case "cloudy" : return "Облачно с прояснениями"
        case "overcast" : return "Пасмурно"
        case "drizzle" : return "Морось"
        case "light-rain" : return "Небольшой дождь"
        case "rain" : return "Дождь"
        case "moderate-rain" : return "Умеренно сильный дождь"
        case "heavy-rain" : return "Сильный дождь"
        case "continuous-heavy-rain" : return "Длительный сильный дождь"
        case "showers" : return "Ливень"
        case "wet-snow" : return "Дождь со снегом"
        case "light-snow" : return "Небольшой снег"
        case "snow" : return "Снег"
        case "snow-showers" : return "Снегопад"
        case "hail" : return "Град"
        case "thunderstorm" : return "гроза"
        case "thunderstorm-with-rain" : return "Дождь с грозой"
        case "thunderstorm-with-hail" : return "Гроза с градом"
        default: return "Непонятно :)"
        }
    }
    
    init(wheatherData: WeatherData) {
        name = wheatherData.geoObject.locality.name
        temperature = wheatherData.fact.temp
        conditionCode = wheatherData.fact.icon
        url = wheatherData.info.url
        condition = wheatherData.fact.condition
        pressure = wheatherData.fact.pressureMm
        windSpeed = wheatherData.fact.windSpeed
        tempMin = wheatherData.forecasts.first!.parts.day.tempMin!
        tempMax = wheatherData.forecasts.first!.parts.day.tempMax!
    }
    
}
