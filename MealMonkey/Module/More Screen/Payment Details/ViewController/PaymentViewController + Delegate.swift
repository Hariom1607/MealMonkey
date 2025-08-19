//
//  PaymentViewController + Delegate.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 07/08/25.
//

import Foundation
import UIKit

// MARK: - Delegates & DataSource
/// Extension for handling TableView, TextField, and PaymentDetailsCell interactions
extension PaymentDetailsViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, PaymentDetailsCellDelegate {
    
    // MARK: - UITableViewDataSource
    /// Returns number of saved cards
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCards.count
    }
    
    /// Configures and returns a card cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentDetailsTableViewCell", for: indexPath) as! PaymentDetailsTableViewCell
        
        // Mask card number before displaying
        cell.lblCardNumber.text = maskedCardNumber(arrCards[indexPath.row])
        cell.delegate = self
        
        return cell
    }
    
    // MARK: - Card Storage
    /// Saves card array to UserDefaults
    func saveCardsToDefaults() {
        UserDefaults.standard.set(arrCards, forKey: "savedCards")
    }
    
    /// Returns masked card number (e.g. "**** **** **** 1234")
    func maskedCardNumber(_ number: String) -> String {
        // Replace all digits except last 4 with "*"
        let masked = String(repeating: "*", count: max(0, number.count - 4)) + number.suffix(4)
        
        // Add spaces every 4 characters
        var result = ""
        for (index, char) in masked.enumerated() {
            if index != 0 && index % 4 == 0 {
                result.append(" ")
            }
            result.append(char)
        }
        return result
    }
    
    // MARK: - PaymentDetailsCellDelegate
    /// Handles delete card button tap
    func didTapDeleteButton(in cell: PaymentDetailsTableViewCell) {
        if let indexPath = tblCardDetails.indexPath(for: cell) {
            arrCards.remove(at: indexPath.row)       // Remove card
            saveCardsToDefaults()                    // Save updated list
            tblCardDetails.reloadData()              // Refresh table
            updateEmptyLabel()                       // Update empty state label
        }
    }
    
    // MARK: - UITextFieldDelegate
    /// Restricts input based on field type (card, expiry, cvv, etc.)
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        // Card number → max 16 digits, numeric only
        if textField == txtCardNumber {
            return newText.count <= 16 && CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string))
        }
        
        // Expiry month, year, and CVV → max 2 digits, numeric only
        if textField == txtExpiryMonth || textField == txtExpiryYear || textField == txtSecurityCode {
            return newText.count <= 2 && CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string))
        }
        
        return true
    }
    
    /// Moves to next field when return is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case txtCardNumber:
            txtExpiryMonth.becomeFirstResponder()
        case txtExpiryMonth:
            txtExpiryYear.becomeFirstResponder()
        case txtExpiryYear:
            txtSecurityCode.becomeFirstResponder()
        case txtSecurityCode:
            txtFirstName.becomeFirstResponder()
        case txtFirstName:
            txtLastName.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
