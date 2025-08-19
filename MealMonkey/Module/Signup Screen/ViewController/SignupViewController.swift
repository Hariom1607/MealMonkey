//
//  SignupViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 01/08/25.
//

import UIKit

class SignupViewController: UIViewController {
    
    
    
    @IBOutlet weak var btnEyeConfirmPassword: UIButton!
    @IBOutlet weak var stackConfirmPassword: UIStackView!
    @IBOutlet weak var stackPassword: UIStackView!
    @IBOutlet weak var btnEyePassword: UIButton!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtMobileNo: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnBackToLogin: UIButton!
    @IBOutlet weak var btnSignup: UIButton!
    
    var isPasswordVisible: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let allFields = [txtName!, txtEmail!, txtAddress!, txtMobileNo!, btnSignup!, stackPassword!, stackConfirmPassword!]
        
        styleViews(allFields, cornerRadius: 28, borderWidth: 0, borderColor: UIColor.black.cgColor)
        
        let allViews = [txtName!, txtEmail!, txtAddress!, txtMobileNo!]
        
        setTextFieldPadding(allViews)
        
        txtPassword.setPadding(left: 34, right: 5)
        txtConfirmPassword.setPadding(left: 34, right: 5)
        
    }
    
    @IBAction func btnEyePasswordAction(_ sender: Any) {
        isPasswordVisible = !isPasswordVisible
        txtPassword.isSecureTextEntry = !isPasswordVisible
        let imageName = isPasswordVisible ? "eye" : "eye.slash"
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
        
    }
    @IBAction func btnEyeConfirmPasswordAction(_ sender: Any) {
        isPasswordVisible = !isPasswordVisible
        txtConfirmPassword.isSecureTextEntry = !isPasswordVisible
        let imageName = isPasswordVisible ? "eye" : "eye.slash"
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    
    @IBAction func btnSignupAction(_ sender: Any) {
        let username = txtName.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let email = txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() ?? ""
        let password = txtPassword.text ?? ""
        let confirmPassword = txtConfirmPassword.text ?? ""
        let address = txtAddress.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let mobileNo = txtMobileNo.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        // ✅ Validations
        switch true {
        case username.isEmpty:
            UIAlertController.showAlert(title: "Name Missing", message: "Please enter your name", viewController: self)
            return
        case email.isEmpty:
            UIAlertController.showAlert(title: "Email Missing", message: "Please enter your email", viewController: self)
            return
        case !isValidEmail(email):
            UIAlertController.showAlert(title: "Invalid Email", message: "Please enter a valid email address", viewController: self)
            return
        case mobileNo.isEmpty:
            UIAlertController.showAlert(title: "Mobile Missing", message: "Please enter your mobile number", viewController: self)
            return
        case address.isEmpty:
            UIAlertController.showAlert(title: "Address Missing", message: "Please enter your address", viewController: self)
            return
        case password.isEmpty:
            UIAlertController.showAlert(title: "Password Missing", message: "Please enter your password", viewController: self)
            return
        case !isValidPassword(password):
            UIAlertController.showAlert(title: "Invalid Password", message: "Please enter a stronger password", viewController: self)
            return
        case confirmPassword.isEmpty:
            UIAlertController.showAlert(title: "Confirm Password Missing", message: "Please re-enter password", viewController: self)
            return
        case password != confirmPassword:
            UIAlertController.showAlert(title: "Passwords Do Not Match", message: "Password and confirm password must match", viewController: self)
            return
        default: break
        }
        
        if CoreDataHelper.shared.saveUser(
            name: username,
            email: email,
            password: password,
            address: address,
            mobile: mobileNo
        ) {
            showAlert("✅ Signup successful! Please login.", completion: {
                self.dismiss(animated: true)
            })
        } else {
            showAlert("⚠️ User already exists, try logging in.")
        }
        
    }
    
    private func showAlert(_ message: String, completion: (() -> Void)? = nil) {
           let alert = UIAlertController(title: "Signup", message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
               completion?()
           })
           present(alert, animated: true)
       }
    @IBAction func btnBackToLogin(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "UserLoginStoryboard", bundle: nil)
        if ((storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController) != nil){
            self.navigationController?.popViewController(animated: true)
            
        }
    }
}

extension SignupViewController: UITextFieldDelegate {
    func textFieldShouldReturn (_ textField: UITextField) -> Bool{
        if textField == txtName && textField.returnKeyType == .next{
            txtName.resignFirstResponder()
            txtEmail.becomeFirstResponder()
        }
        else if textField == txtEmail && textField.returnKeyType == .next{
            txtEmail.resignFirstResponder()
            txtMobileNo.becomeFirstResponder()
        }
        else if textField == txtMobileNo && textField.returnKeyType == .next{
            txtMobileNo.resignFirstResponder()
            txtAddress.becomeFirstResponder()
        }
        else if textField == txtAddress && textField.returnKeyType == .next{
            txtAddress.resignFirstResponder()
            txtPassword.becomeFirstResponder()
        }
        else if textField == txtPassword && textField.returnKeyType == .next{
            txtPassword.resignFirstResponder()
            txtConfirmPassword.becomeFirstResponder()
        }
        else{
            txtConfirmPassword.resignFirstResponder()
        }
        return true
    }
}
