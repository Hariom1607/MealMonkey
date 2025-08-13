//
//  CheckoutViewController + Delegate.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 08/08/25.
//

import Foundation
import UIKit

extension CheckoutViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + arrCards.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CashOnDeliveryTableViewCell", for: indexPath) as! CashOnDeliveryTableViewCell
            cell.btnCashOnDeliverySelection.isSelected = (selectedPaymentIndex == 0)
            return cell
            
        case 1..<(1 + arrCards.count):
            let cell = tableView.dequeueReusableCell(withIdentifier: "CardTableViewCell", for: indexPath) as! CardTableViewCell
            let cardIndex = indexPath.row - 1
            cell.lblCardNumber.text = maskedCardNumber(arrCards[cardIndex])
            cell.btnCardSelection.isSelected = (selectedPaymentIndex == indexPath.row)
            return cell
            
        case 1 + arrCards.count:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UpiTableViewCell", for: indexPath) as! UpiTableViewCell
            cell.btnUpiSelection.isSelected = (selectedPaymentIndex == indexPath.row)
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func updateOrderSummary() {
        let subtotal = orderProducts.reduce(0) { $0 + ($1.doubleProductPrice * Double($1.intProductQty ?? 1)) }
        let total = subtotal + deliveryCost
        
        lblSubTotal.text = "$\(String(format: "%.2f", subtotal))"
        lblDeliveryCost.text = "$\(String(format: "%.2f", deliveryCost))"
        lblTotal.text = "$\(String(format: "%.2f", total))"
    }
    
    func saveCardFromPopup(cardNumber: String) {
        addNewCard(cardNumber) // Save to UserDefaults
        arrCards = getSavedCards() // Update local array
        tblPaymentDetails.reloadData() // Refresh table
    }
    
    func closeAddCardPopup() {
        UIView.animate(withDuration: 0.3, animations: {
            self.addCardView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
            self.viewTransparent.isHidden = true
        }) { _ in
            self.addCardView.isHidden = true
            self.tabBarController?.tabBar.isHidden = false
            self.navigationController?.navigationBar.backgroundColor  = UIColor.white
            self.txtCardNumber.text = "" // Clear text field
        }
    }
    
    func maskedCardNumber(_ number: String) -> String {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPaymentIndex = indexPath.row
        tblPaymentDetails.reloadData() // Refresh to update filled circle
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Invalid Input", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    func saveCardsToDefaults() {
        UserDefaults.standard.set(arrCards, forKey: "SavedCards")
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
