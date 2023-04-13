//
//  WeatherViewController.swift
//  Weather App Demo
//
//  Created by Sorfian on 13/04/23.
//

import UIKit
import WeatherInfoKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var city: String = "Paris"
    var country: String = "France"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        weatherLabel.text = ""
        temperatureLabel.text = ""
        
        displayCurrentWeather()
        
    }
    
    func displayCurrentWeather() {
//        Update location
        cityLabel.text = city
        countryLabel.text = country
        
//        Invoke weather service to get the weather data
        WeatherService.sharedWeatherService().getCurrentWeather(location: city) { data in
            OperationQueue.main.addOperation {
                if let weatherData = data {
                    self.weatherLabel.text = weatherData.weather.capitalized
                    self.temperatureLabel.text = String(format: "%d", weatherData.temperature) + "\u{00B0}"
                }
            }
        }
    }
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func updateWeatherInfo(segue: UIStoryboardSegue) {
        let sourceViewController = segue.source as! LocationTableViewController
        
        city = sourceViewController.selectedCity
        country = sourceViewController.selectedCountry
        
        displayCurrentWeather()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLocations" {
            let destinationController = segue.destination as! UINavigationController
            let locationTableViewController = destinationController.viewControllers[0] as! LocationTableViewController
            locationTableViewController.selectedLocation = "\(city), \(country)"
        }
    }
    

}
