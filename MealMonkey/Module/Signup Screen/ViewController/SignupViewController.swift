//
//  SignupViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 01/08/25.
//

import UIKit

class SignupViewController: UIViewController {

    
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtMobileNo: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var btnBackToLogin: UIButton!
    @IBOutlet weak var btnSignup: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let allFields = [txtName!, txtPassword!, txtEmail!, txtAddress!, txtMobileNo!, txtConfirmPassword!, btnSignup!]
        
        styleViews(allFields, cornerRadius: 28, borderWidth: 0, borderColor: UIColor.black.cgColor)
        
        txtName.setPadding(left: 34)
        txtAddress.setPadding(left: 34)
        txtEmail.setPadding(left: 34)
        txtPassword.setPadding(left: 34)
        txtPassword.setPadding(left: 34)
        txtConfirmPassword.setPadding(left: 34)
        txtMobileNo.setPadding(left: 34)

        
        
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
