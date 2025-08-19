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
        // 1 (COD) + all saved cards + 1 (UPI)
        return 1 + arrCards.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            // Case 0 → Cash on Delivery cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "CashOnDeliveryTableViewCell", for: indexPath) as! CashOnDeliveryTableViewCell
            cell.btnCashOnDeliverySelection.isSelected = (selectedPaymentIndex == 0)
            return cell
            
        case 1..<(1 + arrCards.count):
            // Cases 1...N → Card cells (from arrCards)
            let cell = tableView.dequeueReusableCell(withIdentifier: "CardTableViewCell", for: indexPath) as! CardTableViewCell
            let cardIndex = indexPath.row - 1
            cell.lblCardNumber.text = maskedCardNumber(arrCards[cardIndex])
            cell.btnCardSelection.isSelected = (selectedPaymentIndex == indexPath.row)
            return cell
            
        case 1 + arrCards.count:
            // Last case → UPI cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "UpiTableViewCell", for: indexPath) as! UpiTableViewCell
            cell.btnUpiSelection.isSelected = (selectedPaymentIndex == indexPath.row)
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func updateOrderSummary() {
        // Calculate subtotal = sum(productPrice * qty)
        let subtotal = orderProducts.reduce(0) { $0 + ($1.doubleProductPrice * Double($1.intProductQty ?? 1)) }
        
        // Fixed discount
        let discount: Double = 4.0
        
        // Calculate final total
        let total = subtotal + deliveryCost - discount
        
        // Update labels
        lblSubTotal.text = "$\(String(format: "%.2f", subtotal))"
        lblDeliveryCost.text = "$\(String(format: "%.2f", deliveryCost))"
        lblDiscount.text = "-$\(String(format: "%.2f", discount))"
        lblTotal.text = "$\(String(format: "%.2f", total))"
    }
    
    func saveCardFromPopup(cardNumber: String) {
        // Save card to UserDefaults (helper function assumed)
        addNewCard(cardNumber)
        arrCards = getSavedCards() // Refresh local array
        tblPaymentDetails.reloadData() // Reload table view
    }
    
    func closeAddCardPopup() {
        // Animate popup dismissal
        UIView.animate(withDuration: 0.3, animations: {
            self.addCardView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
            self.viewTransparent.isHidden = true
        }) { _ in
            self.addCardView.isHidden = true
            self.tabBarController?.tabBar.isHidden = false
            self.navigationController?.navigationBar.backgroundColor  = UIColor.white
            self.txtCardNumber.text = "" // Clear text field after closing
        }
    }
    
    func maskedCardNumber(_ number: String) -> String {
        // Mask all digits except last 4
        let last4 = number.suffix(4)
        let masked = String(repeating: "*", count: max(0, number.count - 4))
        
        var result = ""
        for (index, char) in (masked + last4).enumerated() {
            if index != 0 && index % 4 == 0 {
                result.append(" ") // Add space every 4 chars
            }
            result.append(char)
        }
        return result
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Update selected payment method
        selectedPaymentIndex = indexPath.row
        tblPaymentDetails.reloadData() // Refresh UI to update radio buttons
    }
    
    func showAlert(message: String) {
        // Generic alert for validation errors
        let alert = UIAlertController(title: "Invalid Input", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    func saveCardsToDefaults() {
        // ⚠️ NOTE: In CheckoutViewController you use "savedCards" (lowercase s)
        // Here you're using "SavedCards" (uppercase S).
        // This will cause inconsistency if both are used.
        UserDefaults.standard.set(arrCards, forKey: "SavedCards")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Move to next text field in sequence
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
