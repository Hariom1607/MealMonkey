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
        return savedCards.count
    }
    
    /// Configures and returns a card cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentDetailsTableViewCell", for: indexPath) as! PaymentDetailsTableViewCell
        
        let card = savedCards[indexPath.row]
        // Mask card number before displaying
        cell.lblCardNumber.text = CardHelper.maskedCardNumber(card.cardNumber ?? "")
        cell.delegate = self
        
        return cell
    }
    
    // MARK: - PaymentDetailsCellDelegate
    /// Handles delete card button tap
    func didTapDeleteButton(in cell: PaymentDetailsTableViewCell) {
        if let indexPath = tblCardDetails.indexPath(for: cell) {
            let card = savedCards[indexPath.row]
            CoreDataHelper.shared.deleteCard(card)
            loadSavedCards()  // reload after deletion
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
        
        // Expiry month and year → max 2 digits, numeric only
        if textField == txtExpiryMonth || textField == txtExpiryYear {
            return newText.count <= 2 && CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string))
        }
        
        // CVV → max 3 digits, numeric only
        if textField == txtSecurityCode {
            return newText.count <= 3 && CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string))
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
