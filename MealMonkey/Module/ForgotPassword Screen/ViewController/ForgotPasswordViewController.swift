//
//  ForgotPasswordViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 01/08/25.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var lblTitleForgotPassword: UILabel!
    @IBOutlet weak var subTitile: UILabel! //Please enter your email to receive a link to  create a new password via email
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Update navigation title
        setLeftAlignedTitleWithBack(Localized("lbl_forgotpassword_nav_title"), target: self, action: #selector(backButtonTapped))
        
        // Update labels
        lblTitleForgotPassword.text = Localized("lbl_forgotpassword_title")
        subTitile.text = Localized("lbl_forgotpassword_subtitle")
        
        // Update textfield placeholder
        txtEmail.placeholder = Localized("txtfield_email_placeholder")
        
        // Update button title
        btnSend.setTitle(Localized("btn_send"), for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyTheme()
        
        // ✅ Listen for theme changes
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applyTheme),
            name: NSNotification.Name("themeChanged"),
            object: nil
        )
        
        // Show navigation bar
        self.navigationController?.navigationBar.isHidden = false
        
        // Apply styling to email field & button
        let allViews = [txtEmail!, btnSend!]
        styleViews(allViews, cornerRadius: 28, borderWidth: 0, borderColor: UIColor.black.cgColor)
        
        // Add padding inside the email text field
        txtEmail?.placeholder = Main.ForgotPassword.txtEmailPlaceholder
        txtEmail.setPadding(left: 34, right: 34)
        
        // Set navigation bar title with a back button
        setLeftAlignedTitleWithBack(Main.ForgotPassword.navTitle, target: self, action: #selector(backButtonTapped))
        lblTitleForgotPassword.text = Main.ForgotPassword.title
        subTitile.text = Main.ForgotPassword.subtitle
        
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
                title: Main.ForgotPassword.alertEmailMissing,
                message: Main.ForgotPassword.validationEmailMissing,
                viewController: self
            )
            return
        }
        
        // ✅ Validate email format
        if !isValidEmail(email) {
            UIAlertController.showAlert(
                title: Main.ForgotPassword.alertInvalidEmail,
                message: Main.ForgotPassword.validationInvalidEmail,
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
            alert.addAction(UIAlertAction(title: Main.ForgotPassword.okBtn, style: .default, handler: { _ in
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
            UIAlertController.showAlert(
                title: Main.ForgotPassword.alertInvalidEmail,
                message: Main.ForgotPassword.noAccountFound,
                viewController: self
            )
        }
    }
    deinit {
        // ✅ Clean up notification
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("themeChanged"), object: nil)
    }
    
    // MARK: - Theme
    @objc private func applyTheme() {
        let theme = ThemeManager.currentTheme
        view.backgroundColor = theme.backgroundColor
        lblTitleForgotPassword.textColor = theme.titleColor
        subTitile.textColor = theme.secondaryFontColor
        txtEmail.textColor = theme.labelColor
        txtEmail.backgroundColor = theme.secondaryFontColor.withAlphaComponent(0.1)
        btnSend.backgroundColor = theme.buttonColor
        btnSend.setTitleColor(theme.titleColor, for: .normal)
    }
}
