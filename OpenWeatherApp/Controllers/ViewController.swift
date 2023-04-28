//
//  ViewController.swift
//  OpenWeatherApp
//
//  Created by Vlad on 27.04.2023.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTemperatureLabel: UILabel!
    
    //MARK: - Variables
    var networkWeatherService = NetworkWeatherService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkWeatherService.delegate = self
        networkWeatherService.fetchCurrentWeather(forCity: "London")
        
    }
    
    //MARK: - IBAction
    @IBAction func searchPressed(_ sender: UIButton) {
        presentSerchAlertController { city in
            self.networkWeatherService.fetchCurrentWeather(forCity: city)
            
        }
    }

    //MARK: - Methods
    private func presentSerchAlertController(completionHandler: @escaping (String) -> Void) {
        let alertController = UIAlertController(title: "Enter city name", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "London"
        }
        
        let searchAction = UIAlertAction(title: "Search", style: .default) { action in
            let textField = alertController.textFields?.first
            if let cityName = textField?.text {
                if cityName != "" {
                    let city = cityName.split(separator: " ").joined(separator: "%20")
                    completionHandler(city)
                }
            }
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(searchAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
}

extension ViewController: NetworkWeatherServiceProtocol {
    func updateUserInterface(_: NetworkWeatherService, with currentWeather: CurrentWeather) {
        DispatchQueue.main.async {
            self.cityLabel.text = currentWeather.cityName
            self.temperatureLabel.text = "\(currentWeather.temperatureString) ℃"
            self.feelsLikeTemperatureLabel.text = "Feels like \(currentWeather.feelsLikeTemperatureString) ℃"
            
            
            self.weatherIconImageView.image = UIImage(systemName: currentWeather.systemIconNameString)
        }
    }
}

