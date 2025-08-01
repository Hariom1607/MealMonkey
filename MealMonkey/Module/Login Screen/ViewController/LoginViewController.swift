//
//  LoginViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 31/07/25.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnSignup: UIButton!
    @IBOutlet weak var btnGoogleLogin: UIButton!
    @IBOutlet weak var btnFacebookLogin: UIButton!
    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let allViews = [txtEmail!, txtPassword!, btnLogin!, btnSignup!, btnGoogleLogin!, btnFacebookLogin!, btnForgotPassword!]
        
        styleViews(allViews, cornerRadius: 28, borderWidth: 0, borderColor: UIColor.black.cgColor)
        
        txtEmail.setPadding(left: 34)
        txtPassword.setPadding(left: 34)
        
        
        
        
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnLoginAction(_ sender: Any) {
    }
    
    @IBAction func btnForgotPasswordAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "UserLoginStoryboard", bundle: nil)
        if let mlvc = storyboard.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as? ForgotPasswordViewController{
            self.navigationController?.pushViewController(mlvc, animated: true)
        }
        
    }
    
    @IBAction func btnLoginFaceBookAction(_ sender: Any) {
    }
    
    @IBAction func btnLoginGoogleAction(_ sender: Any) {
    }
    
    @IBAction func btnSignupAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "UserLoginStoryboard", bundle: nil)
        if let mlvc = storyboard.instantiateViewController(withIdentifier: "SignupViewController") as? SignupViewController{
            self.navigationController?.pushViewController(mlvc, animated: true)
            
        }
        
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn (_ textField: UITextField) -> Bool{
        if textField == txtEmail && textField.returnKeyType == .next{
            txtEmail.resignFirstResponder()
            txtPassword.becomeFirstResponder()
        }
        else{
            txtPassword.resignFirstResponder()
        }
        return true
    }
}
