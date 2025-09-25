//
//  NewPasswordViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 04/08/25.
//

import UIKit

class NewPasswordViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var lblTitleNewPassword: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel! //Please enter your email to receive a link to  create a new password via email
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
        
        // ✅ Apply theme once
        applyTheme()
        
        // ✅ Observe theme changes
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applyTheme),
            name: NSNotification.Name("themeChanged"),
            object: nil
        )
        
        // Set localized texts
        lblTitleNewPassword.text = Main.NewPassword.title
        lblSubTitle.text = Main.NewPassword.subtitle
        txtNewPassword.placeholder = Main.NewPassword.newPasswordPlaceholder
        txtConfirmPassword.placeholder = Main.NewPassword.confirmPasswordPlaceholder
        btnSubmit.setTitle(Main.NewPassword.btnSubmit, for: .normal)
        
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
        setLeftAlignedTitleWithBack(Main.NewPassword.navTitle, target: self, action: #selector(backButtonTapped))
    }
    
    // MARK: - Navigation
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Actions
    @IBAction func btnSubmit(_ sender: Any) {
        guard let email = self.email else { return }
        
        let newPassword = txtNewPassword.text ?? ""
        let confirmPassword = txtConfirmPassword.text ?? ""
        
        switch true {
        case newPassword.isEmpty:
            UIAlertController.showAlert(title: Main.NewPassword.alertPasswordMissing,
                                        message: Main.NewPassword.validationPasswordMissing,
                                        viewController: self)
            return
        case confirmPassword.isEmpty:
            UIAlertController.showAlert(title: Main.NewPassword.alertConfirmPasswordMissing,
                                        message: Main.NewPassword.validationConfirmPasswordMissing,
                                        viewController: self)
        case newPassword != confirmPassword:
            UIAlertController.showAlert(title: Main.NewPassword.alertPasswordMismatch,
                                        message: Main.NewPassword.validationPasswordMismatch,
                                        viewController: self)
        default:
            break
        }
        
        let success = CoreDataHelper.shared.updateUser(
            oldEmail: email,
            newEmail: nil,
            name: nil,
            mobile: nil,
            address: nil,
            password: newPassword,
            imageData: nil
        )
        
        if success {
            let storyboard = UIStoryboard(name: Main.storyboards.feature, bundle: nil)
            if let mlvc = storyboard.instantiateViewController(
                identifier: Main.viewController.feature
            ) as? FeatureViewController {
                self.navigationController?.pushViewController(mlvc, animated: true)
            }
        } else {
            UIAlertController.showAlert(
                title: Main.NewPassword.alertError,
                message: Main.NewPassword.alertProfileUpdateFailed,
                viewController: self
            )
        }
    }
    
    @IBAction func btnEyeConfirmPasswordAction(_ sender: Any) {
        isPasswordVisible.toggle()
        txtConfirmPassword.isSecureTextEntry = !isPasswordVisible
        
        let imageName = isPasswordVisible ? Main.images.eye : Main.images.eyeSlash
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    
    @IBAction func btnEyePasswordAction(_ sender: Any) {
        isPasswordVisible.toggle()
        txtNewPassword.isSecureTextEntry = !isPasswordVisible
        
        let imageName = isPasswordVisible ? Main.images.eye : Main.images.eyeSlash
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    
    @objc private func applyTheme() {
        let theme = ThemeManager.currentTheme
        view.backgroundColor = theme.backgroundColor
        lblTitleNewPassword.textColor = theme.titleColor
        lblSubTitle.textColor = theme.secondaryFontColor
        txtNewPassword.textColor = theme.labelColor
        txtConfirmPassword.textColor = theme.labelColor
        txtNewPassword.backgroundColor = theme.secondaryFontColor.withAlphaComponent(0.1)
        txtConfirmPassword.backgroundColor = theme.secondaryFontColor.withAlphaComponent(0.1)
        btnSubmit.backgroundColor = theme.buttonColor
        btnSubmit.setTitleColor(theme.titleColor, for: .normal)
        
        // Optional: match eye icons with theme
        btnEyePassword.tintColor = theme.placeholderColor
        btnEyeConfirmPassword.tintColor = theme.placeholderColor
    }
    
    deinit {
        // ✅ Remove observer
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("themeChanged"), object: nil)
    }
}

// MARK: - UITextFieldDelegate
extension NewPasswordViewController: UITextFieldDelegate {
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
