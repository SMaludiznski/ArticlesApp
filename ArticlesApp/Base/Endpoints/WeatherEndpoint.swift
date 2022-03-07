//
//  WeatherEndpoint.swift
//  NewsApp
//
//  Created by Sebastian Maludziński on 12/02/2022.
//

import Foundation

enum WeatherEndpoint: Endpoint {
    case fetchWeather(city: String)
    case fetchWeatherFrom(lat: Double, lon: Double)
    
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    var baseURL: String {
        switch self {
        default:
            return "api.openweathermap.org"
        }
    }
    
    var path: String {
        switch self {
        default:
            return "/data/2.5/weather"
        }
    }
    
    var parameters: [URLQueryItem] {
        let weatherApiKey = "ccd8d1e8ded6e780ce5217af3a63247c"
        
        switch self {
        case .fetchWeather(let name):
            return[URLQueryItem(name: "q", value: name),
                   URLQueryItem(name: "units", value: "metric"),
                   URLQueryItem(name: "appid", value: weatherApiKey)]
            
        case.fetchWeatherFrom(let lat, let lon):
            let lat = String(lat)
            let lon = String(lon)
            
            return[URLQueryItem(name: "lat", value: lat),
                   URLQueryItem(name: "lon", value: lon),
                   URLQueryItem(name: "units", value: "metric"),
                   URLQueryItem(name: "appid", value: weatherApiKey)]
        }
    }
    
    var method: String {
        switch self {
        default:
            return "GET"
        }
    }
}
