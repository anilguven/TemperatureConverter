//
//  TemperatureViewModel.swift
//  LengthConversions
//
//  Created by Anil Guven on 25/11/2023.
//

import Foundation

struct TemperatureViewModel {
    
    // MARK: - Properties
    private var temperature: Temperature
    
    // MARK: - Life Cycle
    init(temperature: Temperature) {
        self.temperature = temperature
    }
    
    // MARK: - Methods
    func formattedValue(for unit: Temperature.Unit) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        
        let rawValue = switch unit {
        case .kelvin:
            temperature.kelvinValue
        case .fahrenheit:
            temperature.fahrenheitValue
        case .celcius:
            temperature.celciusValue
        }
        
        let formattedValue = numberFormatter.string(
            from: NSNumber(value: rawValue)
        )
        
        return formattedValue
    }
}
