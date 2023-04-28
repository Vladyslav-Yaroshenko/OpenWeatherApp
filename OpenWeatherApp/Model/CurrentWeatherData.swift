//
//  CurrentWeatherData.swift
//  OpenWeatherApp
//
//  Created by Vlad on 28.04.2023.
//

import Foundation

struct CurrentWeatherData {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main {
    let temp, feels_like: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
    }
}

struct Weather {
    let id: Int
}
