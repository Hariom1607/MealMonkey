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
        
        let allViews = [txtName!, txtPassword!, txtEmail!, txtAddress!, txtMobileNo!, txtConfirmPassword!]
        
        setTextFieldPadding(allViews)
        
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
