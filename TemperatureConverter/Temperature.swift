//
//  Temperature.swift
//  LengthConversions
//
//  Created by Anil Guven on 18/11/2023.
//

import Foundation

struct Temperature {
    
    enum Unit: Int {
        case celcius
        case fahrenheit
        case kelvin
        
        var name: String {
            switch self {
            case .celcius:
                return "Celcius"
                
            case .fahrenheit:
                return "Fahrenheit"
                
            case .kelvin:
                return "Kelvin"
            }
        }
    }
    
    // MARK: - Properties
    private(set) var celciusValue: Double
    private(set) var fahrenheitValue: Double
    private(set) var kelvinValue: Double
    
    // MARK: - Life Cycle
    init(value: Double, unit: Unit) {
        // let fd = Measurement.init(value: 12, unit: UnitTemperature.celsius)
        // let ff = fd.converted(to: .fahrenheit)
        
        switch unit {
        case .celcius:
            celciusValue = value
            fahrenheitValue = value * 1.8 + 32
            kelvinValue = value + 273.15
            
        case .fahrenheit:
            fahrenheitValue = value
            celciusValue = (value - 32) * 5.0 / 9.0
            kelvinValue = (value + 459.67) * 5.0 / 9.0
            
        case .kelvin:
            kelvinValue = value
            celciusValue = value - 273.15
            fahrenheitValue = value * 1.8 - 459.67
        }
    }
}
