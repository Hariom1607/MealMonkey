//
//  PaymentViewController + Delegate.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 07/08/25.
//

import Foundation
import UIKit

extension PaymentDetailsViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, PaymentDetailsCellDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentDetailsTableViewCell", for: indexPath) as! PaymentDetailsTableViewCell
        
        cell.lblCardNumber.text = maskedCardNumber(arrCards[indexPath.row])
        cell.delegate = self
        
        return cell
    }
    
    func saveCardsToDefaults() {
        UserDefaults.standard.set(arrCards, forKey: "savedCards")
    }
    
    func maskedCardNumber(_ number: String) -> String {
        let masked = String(repeating: "*", count: max(0, number.count - 4)) + number.suffix(4)
        var result = ""
        for (index, char) in masked.enumerated() {
            if index != 0 && index % 4 == 0 {
                result.append(" ")
            }
            result.append(char)
        }
        return result
    }
    
    func didTapDeleteButton(in cell: PaymentDetailsTableViewCell) {
        if let indexPath = tblCardDetails.indexPath(for: cell) {
            arrCards.remove(at: indexPath.row)
            saveCardsToDefaults()
            tblCardDetails.reloadData()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Current text
        let currentText = textField.text ?? ""
        // New text after typing
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        if textField == txtCardNumber {
            return newText.count <= 16 && CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string))
        }
        if textField == txtExpiryMonth || textField == txtExpiryYear || textField == txtSecurityCode {
            return newText.count <= 2 && CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string))
        }
        return true
    }
    
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
