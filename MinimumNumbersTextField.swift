//
//  MinimumNumbersTextField.swift
//  RealEstates
//
//  Created by Botan Amedi on 16/07/2024.
//

import UIKit

@IBDesignable
class CustomTextField: UITextField, UITextFieldDelegate {
    
    // IBInspectable properties for minimum and maximum characters
    @IBInspectable var minimumCharacters: Int = 0
    @IBInspectable var maximumCharacters: Int = 3
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        self.delegate = self
        self.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }
    
    @objc private func editingChanged() {
        guard let text = self.text else { return }
        
        if text.count < minimumCharacters || text.count > maximumCharacters {
            // Optionally, you could change the text color or border color to indicate the error
            self.layer.borderColor = UIColor.red.cgColor
            self.layer.borderWidth = 1.0
        } else {
            // Reset the border color when the text length is within the valid range
            self.layer.borderColor = UIColor.clear.cgColor
            self.layer.borderWidth = 0.0
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Get the current text, considering the change
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        // Allow the change only if the new text length is within the maximum limit
        return updatedText.count <= maximumCharacters
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // Check if the text meets the minimum character requirement
        if let text = self.text, text.count < minimumCharacters {
            // Optionally, show an alert or any other indication to the user
            print("Minimum \(minimumCharacters) characters required.")
            return false
        }
        return true
    }
}
