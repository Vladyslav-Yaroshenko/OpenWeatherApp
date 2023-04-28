//
//  NetworkWeatherService.swift
//  OpenWeatherApp
//
//  Created by Vlad on 28.04.2023.
//

import Foundation

struct NetworkWeatherService {
    func fetchCurrentWeather() {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=London&appid=375206eaf4159d0340a53df66d5aea32"
        let url = URL(string: urlString)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url!) { data, response, error in
            if let data = data {
                let dataString = String(data: data, encoding: .utf8)
                print(dataString!)
            }
        }
        task.resume()
    }
}
