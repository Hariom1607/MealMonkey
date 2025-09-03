//
//  ForgotPasswordViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 01/08/25.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Show navigation bar
        self.navigationController?.navigationBar.isHidden = false
        
        // Apply styling to email field & button
        let allViews = [txtEmail!, btnSend!]
        styleViews(allViews, cornerRadius: 28, borderWidth: 0, borderColor: UIColor.black.cgColor)
        
        // Add padding inside the email text field
        txtEmail.setPadding(left: 34, right: 34)
        
        // Set navigation bar title with a back button
        setLeftAlignedTitleWithBack(Main.backBtnTitle.forgotPassword, target: self, action: #selector(backButtonTapped))
    }
    
    // MARK: - Navigation
    @objc func backButtonTapped() {
        // Go back to previous screen
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Actions
    @IBAction func btnSendAction(_ sender: Any) {
        
        // Trim spaces and lowercase email
        let email = txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() ?? ""
        
        // ✅ Check if email field is empty
        if email.isEmpty {
            UIAlertController.showAlert(
                title: Main.AlertTitle.EmailMissing,
                message: Main.ValidationMessages.emailMissing,
                viewController: self
            )
            return
        }
        
        // ✅ Validate email format
        if !isValidEmail(email) {
            UIAlertController.showAlert(
                title: Main.AlertTitle.InvalidEmail,
                message: Main.ValidationMessages.invalidEmail,
                viewController: self
            )
            return
        }
        
        if let _ = CoreDataHelper.shared.fetchUser(email: email){
            
            // ✅ If valid, show success alert
            
            let alert = UIAlertController(
                title: Main.AlertTitle.otpSent,
                message: "An OTP has been sent to \(email)",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: Main.AlertTitle.okBtn, style: .default, handler: { _ in
                // Navigate to OTP screen after user taps OK
                let storyboard = UIStoryboard(name: Main.storyboards.userlogin, bundle: nil)
                if let otpVC = storyboard.instantiateViewController(identifier: Main.viewController.otp) as? OtpViewController {
                    otpVC.email = email
                    self.navigationController?.pushViewController(otpVC, animated: true)
                }
            }))
            
            // Present alert
            self.present(alert, animated: true)
        }
        else {
            UIAlertController.showAlert(title: Main.AlertTitle.InvalidEmail, message: Main.ValidationMessages.noAccFoundEmail, viewController: self)
        }
    }
}
