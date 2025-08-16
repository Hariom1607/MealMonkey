//
//  NewPasswordViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 04/08/25.
//

import UIKit

class NewPasswordViewController: UIViewController {
    
    @IBOutlet weak var btnEyeConfirmPassword: UIButton!
    @IBOutlet weak var btnEyePassword: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    
    var isPasswordVisible: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let allViews = [txtNewPassword!, txtConfirmPassword!, btnSubmit!, btnEyePassword!, btnEyeConfirmPassword!]
        styleViews(allViews, cornerRadius: 28, borderWidth: 0, borderColor: UIColor.black.cgColor)
        
        txtNewPassword.setPadding(left: 34, right: 48)
        txtConfirmPassword.setPadding(left: 34, right: 48)
        
        setLeftAlignedTitleWithBack("New Password", target: self, action: #selector(backButtonTapped))
        
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSubmit(_ sender: Any) {
        let storyboard = UIStoryboard(name: "FeatureStoryboard", bundle: nil)
        if let mlvc = storyboard.instantiateViewController(identifier: "FeatureViewController") as? FeatureViewController{
            self.navigationController?.pushViewController(mlvc, animated: true)
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
    
    @IBAction func btnEyePasswordAction(_ sender: Any) {
        isPasswordVisible = !isPasswordVisible
        txtNewPassword.isSecureTextEntry = !isPasswordVisible
        let imageName = isPasswordVisible ? "eye" : "eye.slash"
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
}

extension NewPasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn (_ textField: UITextField) -> Bool{
        if textField == txtNewPassword && textField.returnKeyType == .next{
            txtNewPassword.resignFirstResponder()
            txtConfirmPassword.becomeFirstResponder()
        }
        else{
            txtConfirmPassword.resignFirstResponder()
        }
        return true
    }
}
