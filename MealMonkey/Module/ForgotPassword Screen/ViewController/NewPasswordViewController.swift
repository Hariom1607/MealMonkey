//
//  NewPasswordViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 04/08/25.
//

import UIKit

class NewPasswordViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var btnEyeConfirmPassword: UIButton!
    @IBOutlet weak var btnEyePassword: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    
    // MARK: - Properties
    var email: String?
    var isPasswordVisible: Bool = false   // Used to toggle password visibility
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Apply rounded style to fields and buttons
        let allViews = [
            txtNewPassword!,
            txtConfirmPassword!,
            btnSubmit!,
            btnEyePassword!,
            btnEyeConfirmPassword!
        ]
        styleViews(allViews, cornerRadius: 28, borderWidth: 0, borderColor: UIColor.black.cgColor)
        
        // Add padding inside password fields
        txtNewPassword.setPadding(left: 34, right: 48)
        txtConfirmPassword.setPadding(left: 34, right: 48)
        
        // Set navigation bar title with back button
        setLeftAlignedTitleWithBack("New Password", target: self, action: #selector(backButtonTapped))
    }
    
    // MARK: - Navigation
    @objc func backButtonTapped() {
        // Navigate back to previous screen
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Actions
    
    /// Handles submit button tap → navigates to Feature screen
    @IBAction func btnSubmit(_ sender: Any) {
        guard let email = self.email else{return}
        
        let newPassword = txtNewPassword.text ?? ""
        let confirmPassword = txtConfirmPassword.text ?? ""
        
        switch true {
        case newPassword.isEmpty:
            UIAlertController.showAlert(title: "New Password is missing", message: "Please enter your New Password", viewController: self)
            return
        case confirmPassword.isEmpty:
            UIAlertController.showAlert(title: "Confirm Password is missing", message: "Please enter your Confirm Password", viewController: self)
        case newPassword != confirmPassword:
            UIAlertController.showAlert(title: "Mismatch", message: "Passwords do not match", viewController: self)
        default : break
        }
        
        let success = CoreDataHelper.shared.updateUser(oldEmail: email,
                                                       newEmail: nil,
                                                       name: nil,
                                                       mobile: nil,
                                                       address: nil,
                                                       password: newPassword,
                                                       imageData: nil)
        if success{
            let storyboard = UIStoryboard(name: "FeatureStoryboard", bundle: nil)
            if let mlvc = storyboard.instantiateViewController(identifier: "FeatureViewController") as? FeatureViewController {
                self.navigationController?.pushViewController(mlvc, animated: true)
            }
        }
        else {
            UIAlertController.showAlert(title: "Error", message: "Failed to change the password", viewController: self)
        }
    }
    
    /// Toggle visibility for Confirm Password field
    @IBAction func btnEyeConfirmPasswordAction(_ sender: Any) {
        isPasswordVisible.toggle()
        txtConfirmPassword.isSecureTextEntry = !isPasswordVisible
        
        // Change eye icon accordingly
        let imageName = isPasswordVisible ? "eye" : "eye.slash"
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    
    /// Toggle visibility for New Password field
    @IBAction func btnEyePasswordAction(_ sender: Any) {
        isPasswordVisible.toggle()
        txtNewPassword.isSecureTextEntry = !isPasswordVisible
        
        // Change eye icon accordingly
        let imageName = isPasswordVisible ? "eye" : "eye.slash"
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
}

// MARK: - UITextFieldDelegate
extension NewPasswordViewController: UITextFieldDelegate {
    
    /// Handles return key navigation between fields
    func textFieldShouldReturn (_ textField: UITextField) -> Bool {
        if textField == txtNewPassword && textField.returnKeyType == .next {
            txtNewPassword.resignFirstResponder()
            txtConfirmPassword.becomeFirstResponder()
        } else {
            txtConfirmPassword.resignFirstResponder()
        }
        return true
    }
}
