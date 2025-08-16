//
//  ForgotPasswordViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 01/08/25.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        
        let allViews = [txtEmail!, btnSend!]
        styleViews(allViews, cornerRadius: 28, borderWidth: 0, borderColor: UIColor.black.cgColor)
        txtEmail.setPadding(left: 34, right: 34)
        
        setLeftAlignedTitleWithBack("Forgot Password", target: self, action: #selector(backButtonTapped))
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func btnSendAction(_ sender: Any) {
        
        let email = txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() ?? ""
        
        // Check if email is empty
        if email.isEmpty {
            UIAlertController.showAlert(title: "Email Missing", message: "Please enter your email", viewController: self)
            return
        }
        
        if !isValidEmail(email) {
            UIAlertController.showAlert(title: "Invalid Email", message: "Please enter a valid email address", viewController: self)
            return
        }
        
        let alert = UIAlertController(title: "OTP Sent", message: "An OTP has been sent to \(email)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            // Navigate to OTP screen after user taps OK
            let storyboard = UIStoryboard(name: "UserLoginStoryboard", bundle: nil)
            if let otpVC = storyboard.instantiateViewController(identifier: "OtpViewController") as? OtpViewController {
                self.navigationController?.pushViewController(otpVC, animated: true)
            }
        }))
        self.present(alert, animated: true)
    }
}
