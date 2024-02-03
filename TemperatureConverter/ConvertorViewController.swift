//
//  ConvertorViewController.swift
//  LengthConversions
//
//  Created by Anil Guven on 18/11/2023.
//

import UIKit

class ConvertorViewController: UIViewController {

    // MARK: - UI Elements
    @IBOutlet weak var kelvinValueLabel: UILabel!
    @IBOutlet weak var fahrenheitValueLabel: UILabel!
    @IBOutlet weak var celciusValueLabel: UILabel!
    @IBOutlet weak var inputValueTextField: UITextField!
    @IBOutlet weak var unitsSegmentedControl: UISegmentedControl!
    @IBOutlet weak var convertButton: UIButton!
    
    // MARK: - Properties
    var currentUnit: Temperature.Unit = .celcius
    var currentValue: Double?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputValueTextField.becomeFirstResponder()
        updateTextFieldPlaceholder()
    }
    
    // MARK: - Methods
    private func updateTextFieldPlaceholder() {
        inputValueTextField.placeholder = "Value in \(currentUnit.name)"
    }
    
    private func updateResults(with temperature: Temperature) {
        let viewModel = TemperatureViewModel(
            temperature: temperature
        )
        
        kelvinValueLabel.text = viewModel.formattedValue(for: .kelvin)
        fahrenheitValueLabel.text = viewModel.formattedValue(for: .fahrenheit)
        celciusValueLabel.text = viewModel.formattedValue(for: .celcius)
    }
    
    // MARK: - Actions
    @IBAction func unitsSegmentedControlValueChanged(_ segmentedControl: UISegmentedControl) {
        let selectedSegmentIndex = segmentedControl.selectedSegmentIndex
        
        if let newUnit = Temperature.Unit(rawValue: selectedSegmentIndex) {
            currentUnit = newUnit
            updateTextFieldPlaceholder()
            
            if currentValue != nil {
                convertButton.isEnabled = true
            }
        }
    }
    
    @IBAction func inputValueTextFieldEditingChanged(_ textField: UITextField) {
        let inputValidator = NumberFormatter()
        inputValidator.numberStyle = .decimal
        
        guard let text = textField.text, !text.isEmpty else {
            convertButton.isEnabled = false
            currentValue = nil
            return
        }
        
        guard let value = inputValidator.number(from: text)?.doubleValue else {
            convertButton.isEnabled = false
            currentValue = nil
            return
        }
        
        convertButton.isEnabled = true
        currentValue = value
    }
    
    @IBAction func convertButtonTapped(_ button: UIButton) {
        guard let currentValue else { return }
        
        let temperature = Temperature(
            value: currentValue,
            unit: currentUnit
        )
        
        updateResults(with: temperature)
        button.isEnabled = false
    }
    
    @IBAction func resetButtonTapped() {
        celciusValueLabel.text = "-"
        fahrenheitValueLabel.text = "-"
        kelvinValueLabel.text = "-"
        
        inputValueTextField.text = nil
        currentValue = nil
        
        convertButton.isEnabled = false
    }
}
