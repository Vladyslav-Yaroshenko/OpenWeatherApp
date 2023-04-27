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
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    //MARK: - IBAction
    @IBAction func searchPressed(_ sender: UIButton) {
        print("Press button")
    }

}

