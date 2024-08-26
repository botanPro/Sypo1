//
//  PaymentViewController.swift
//  RealEstates
//
//  Created by Botan Amedi on 16/07/2024.
//


import UIKit
import Stripe

class PaymentViewController: UIViewController {
    
    // Create an instance of STPPaymentCardTextField
    let paymentCardTextField = STPPaymentCardTextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add paymentCardTextField to your view hierarchy
        view.addSubview(paymentCardTextField)
        
        // Configure paymentCardTextField's layout (e.g., using Auto Layout)
        paymentCardTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            paymentCardTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            paymentCardTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            paymentCardTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        // Add a pay button
        let payButton = UIButton(type: .system)
        payButton.setTitle("Pay", for: .normal)
        payButton.addTarget(self, action: #selector(payButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(payButton)
        
        payButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            payButton.topAnchor.constraint(equalTo: paymentCardTextField.bottomAnchor, constant: 20),
            payButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    // Handle payment button tap
    @objc func payButtonTapped(_ sender: UIButton) {
        // Create a Stripe token
        let cardParams = STPCardParams()
        cardParams.number = paymentCardTextField.paymentMethodParams.card?.number
        cardParams.expMonth = paymentCardTextField.paymentMethodParams.card?.expMonth as! UInt
        cardParams.expYear = paymentCardTextField.paymentMethodParams.card?.expYear as! UInt
        cardParams.cvc = paymentCardTextField.paymentMethodParams.card?.cvc
        STPAPIClient.shared.createToken(withCard: cardParams) { (token, error) in
            guard let token = token else {
                print("Error creating token: \(error?.localizedDescription ?? "")")
                return
            }
            
            // Send the token to your backend server to process the payment
            self.processPayment(token: token.tokenId)
        }
    }
    
    func processPayment(token: String) {
        // Send the token to your server to process the payment
        // Example: Make an API request to your server with the token
    }
}
