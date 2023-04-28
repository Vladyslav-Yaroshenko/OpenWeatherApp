//
//  ViewController.swift
//  OpenWeatherApp
//
//  Created by Vlad on 27.04.2023.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTemperatureLabel: UILabel!
    
    //MARK: - Variables
    var networkWeatherService = NetworkWeatherService()
    lazy var locationManager: CLLocationManager = {
        let lm = CLLocationManager()
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyKilometer
        lm.requestWhenInUseAuthorization()
        return lm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkWeatherService.delegate = self
        
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.requestLocation()
            }
        }
    }
    
    //MARK: - IBAction
    @IBAction func searchPressed(_ sender: UIButton) {
        presentSerchAlertController { city in
            self.networkWeatherService.fetchCurrentWeather(requestType: .cityName(city: city))
            
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

// MARK: - CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        networkWeatherService.fetchCurrentWeather(requestType: .coordinate(latitude: latitude, longitude: longitude))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    
}
