//
//  WeatherData.swift
//  Weather App Demo
//
//  Created by Sorfian on 13/04/23.
//

import Foundation

public struct WeatherData {
    public var temperature: Int = 0
    public var weather: String = ""
    
    public init() {

    }
    
    public init(temperature: Int, weather: String) {
        self.temperature = temperature
        self.weather = weather
    }
}
