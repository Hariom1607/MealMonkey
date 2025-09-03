//
//  CardHelper.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 21/08/25.
//

import Foundation
import UIKit

class CardHelper {
    
    /// Mask card number except last 4 digits
    static func maskedCardNumber(_ number: String) -> String {
        let last4 = number.suffix(4)
        let masked = String(repeating: "*", count: max(0, number.count - 4))
        
        var result = ""
        for (index, char) in (masked + last4).enumerated() {
            if index != 0 && index % 4 == 0 {
                result.append(" ")
            }
            result.append(char)
        }
        return result
    }
    
    /// Validate card fields
    static func validateCardInputs(cardNumber: String,
                                   expMonth: Int16,
                                   expYear: Int16,
                                   cvv: String,
                                   firstName: String,
                                   lastName: String) -> String? {
        if cardNumber.count != 16 || !CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: cardNumber)) {
            return Main.ValidationMessages.invalidCardInput
        }
        if expMonth < 1 || expMonth > 12 {
            return Main.ValidationMessages.invalidCardInput
        }
        let currentYear = Calendar.current.component(.year, from: Date()) % 100
        if expYear < currentYear {
            return Main.ValidationMessages.invalidCardInput
        }
        if cvv.count < 3 || cvv.count > 4 {
            return Main.ValidationMessages.invalidCardInput
        }
        if firstName.isEmpty || lastName.isEmpty {
            return Main.ValidationMessages.invalidCardInput
        }
        return nil
    }
    
    /// Clear all card input fields
    static func clearCardInputs(in controller: UIViewController) {
        if let checkoutVC = controller as? CheckoutViewController {
            checkoutVC.txtCardNumber.text = ""
            checkoutVC.txtExpiryMonth.text = ""
            checkoutVC.txtExpiryYear.text = ""
            checkoutVC.txtSecurityCode.text = ""
            checkoutVC.txtFirstName.text = ""
            checkoutVC.txtLastName.text = ""
        }
        if let paymentVC = controller as? PaymentDetailsViewController {
            paymentVC.txtCardNumber.text = ""
            paymentVC.txtExpiryMonth.text = ""
            paymentVC.txtExpiryYear.text = ""
            paymentVC.txtSecurityCode.text = ""
            paymentVC.txtFirstName.text = ""
            paymentVC.txtLastName.text = ""
        }
    }
}
