//
//  APIManager.swift
//  Prognoz
//
//  Created by macbookp on 20.06.2021.
//

import Foundation

class ApiManager {
    
    static let shared = ApiManager()
    
    func fetchWeather(latitude: Double, longitude: Double, completionHandler: @escaping (Weather) -> Void) {
        let urlString = "https://api.weather.yandex.ru/v2/forecast?lat=\(latitude)&lon=\(longitude)"
        guard  let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.addValue(apiKey , forHTTPHeaderField: "X-Yandex-API-Key")
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            if let weather = self.parseJSON(withData: data) {
                    completionHandler(weather)
            }
        }
        task.resume()
    }
    
    func parseJSON(withData data: Data) -> Weather? {
        let decoder = JSONDecoder()
        do {
            let weatherData = try decoder.decode(WeatherData.self, from: data)
            let weather = Weather(wheatherData: weatherData)
            return weather
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}

