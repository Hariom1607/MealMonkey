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
        return 1 + savedCards.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            // Case 0 → Cash on Delivery cell
            let cell = tableView.dequeueReusableCell(withIdentifier: Main.cells.checkoutCashCell, for: indexPath) as! CashOnDeliveryTableViewCell
            cell.btnCashOnDeliverySelection.isSelected = (selectedPaymentIndex == 0)
            cell.applyTheme()
            return cell
            
        case 1..<(1 + savedCards.count):
            // Cases 1...N → Card cells (from arrCards)
            let cell = tableView.dequeueReusableCell(withIdentifier: Main.cells.checkoutCardCell, for: indexPath) as! CardTableViewCell
            let cardIndex = indexPath.row - 1
            let card = savedCards[cardIndex]
            cell.lblCardNumber.text = CardHelper.maskedCardNumber(card.cardNumber ?? "")
            cell.btnCardSelection.isSelected = (selectedPaymentIndex == indexPath.row)
            cell.applyTheme()
            return cell
            
        case 1 + savedCards.count:
            // Last case → UPI cell
            let cell = tableView.dequeueReusableCell(withIdentifier: Main.cells.checkoutUpiCell, for: indexPath) as! UpiTableViewCell
            cell.btnUpiSelection.isSelected = (selectedPaymentIndex == indexPath.row)
            cell.applyTheme()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Update selected payment method
        selectedPaymentIndex = indexPath.row
        tblPaymentDetails.reloadData() // Refresh UI to update radio buttons
    }
    
    func showAlert(message: String) {
        // Generic alert for validation errors
        let alert = UIAlertController(title: Main.AlertTitle.invalidInput, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Main.AlertTitle.okBtn, style: .default, handler: nil))
        present(alert, animated: true)
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
    
    @objc func applyTheme() {
        let theme = ThemeManager.currentTheme
        
        // MARK: - Backgrounds
        view.backgroundColor = theme.backgroundColor
        viewMain.backgroundColor = theme.backgroundColor
        addCardView.backgroundColor = theme.cellBackgroundColor
        sendOrderView.backgroundColor = theme.cellBackgroundColor
        
        // MARK: - Labels
        let labels = [lblYoucanremovethiscardatanytime, lblExpiry, lblAddCreditDebitCard,
                      lblDescriptionThankyoupage, lblForYouOrder, lblThankYou,
                      lblDeliveryAddress, lblPaymentMethod, lblSubTotalTitle,
                      lblDeliveryCostTitle, lblDiscountTitle, lblTotalTitle,
                      lblSubTotal, lblDeliveryCost, lblDiscount, lblTotal, lblCurrentLocation]
        labels.forEach { $0?.textColor = theme.primaryFontColor }
        
        // MARK: - Buttons
        let buttons = [btnSendOrder, btnTrackOrder, btnAddNewCardPopUp]
        buttons.forEach {
            $0?.backgroundColor = theme.mainColor
            $0?.setTitleColor(theme.accentColor, for: .normal)
        }
        
        btnLocationChange.tintColor = theme.buttonColor
        btnAddCard.tintColor = theme.buttonColor
        btnBackToHome.tintColor = theme.buttonColor
        btnCloseAddCardView.tintColor = theme.buttonColor
        btnCloseThankyouView.tintColor = theme.buttonColor
        
        tblPaymentDetails.reloadData() // Update cell colors
    }

}
