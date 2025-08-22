//
//  OtpViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 07/08/25.
//

import UIKit

class OtpViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var btnOtpRegeneration: UIButton! // Button to regenerate OTP
    @IBOutlet weak var btnNext: UIButton!            // Button to proceed after OTP verification
    @IBOutlet weak var txt4: UITextField!            // OTP 4th digit field
    @IBOutlet weak var txt3: UITextField!            // OTP 3rd digit field
    @IBOutlet weak var txt2: UITextField!            // OTP 2nd digit field
    @IBOutlet weak var txt1: UITextField!            // OTP 1st digit field
    
    var email: String?
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set navigation bar title with back button
        setLeftAlignedTitleWithBack("OTP", target: self, action: #selector(otpBackBtnTapped))
        
        // Group all textfields into an array for styling
        let allviews = [txt1!, txt2!, txt3!, txt4!]
        
        // Apply rounded corners & styles to OTP textfields
        styleViews(allviews, cornerRadius: 12, borderWidth: 0, borderColor: UIColor.black.cgColor)
        
        // Add padding inside textfields
        setTextFieldPadding(allviews, left: 15, right: 22)
        
        // Configure each OTP textfield
        for tf in allviews {
            tf.delegate = self               // Assign delegate for input handling
            tf.keyboardType = .numberPad     // Show number pad keyboard
            tf.textAlignment = .center       // Center align OTP digits
        }
        
        // Round corners for Next button
        btnNext.layer.cornerRadius = 28
    }
    
    // MARK: - Button Actions
    
    /// Back button tap → navigate back
    @objc func otpBackBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// Regenerate OTP button tap → show alert
    @IBAction func btnOtpRegenerationAction(_ sender: Any) {
        let alert = UIAlertController(
            title: "OTP Sent",
            message: "A new OTP has been sent to your registered mobile number.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    /// Next button tap → navigate to new password screen
    @IBAction func btnNextAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "UserLoginStoryboard", bundle: nil)
        if let mlvc = storyboard.instantiateViewController(identifier: "NewPasswordViewController") as? NewPasswordViewController {
            mlvc.email = email
            self.navigationController?.pushViewController(mlvc, animated: true)
        }
    }
}

// MARK: - UITextField Delegate
extension OtpViewController: UITextFieldDelegate {
    
    /// Handles OTP textfield input behavior
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Allow only numbers
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        guard allowedCharacters.isSuperset(of: characterSet) else {
            return false
        }
        
        // Prevent multiple characters pasted at once
        if string.count > 1 {
            return false
        }
        
        // Case: Entering a digit
        if string.count == 1 {
            textField.text = string
            
            // Auto move to next textfield
            switch textField {
            case txt1:
                txt2.becomeFirstResponder()
            case txt2:
                txt3.becomeFirstResponder()
            case txt3:
                txt4.becomeFirstResponder()
            case txt4:
                txt4.resignFirstResponder() // Close keyboard on last digit
            default:
                break
            }
            return false
        }
        // Case: Backspace pressed (string is empty)
        else if string.isEmpty {
            switch textField {
            case txt4:
                txt3.becomeFirstResponder()
            case txt3:
                txt2.becomeFirstResponder()
            case txt2:
                txt1.becomeFirstResponder()
            default:
                break
            }
            textField.text = "" // Clear the field
            return false
        }
        
        return true
    }
}
