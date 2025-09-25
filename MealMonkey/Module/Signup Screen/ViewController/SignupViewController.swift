//
//  SignupViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 01/08/25.
//

import UIKit

class SignupViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var lblAddYOurDetailsToSignUpPage: UILabel!
    @IBOutlet weak var lblSignUpTitle: UILabel!
    @IBOutlet weak var btnEyeConfirmPassword: UIButton!   // Button to toggle confirm password visibility
    @IBOutlet weak var stackConfirmPassword: UIStackView! // StackView wrapping confirm password field
    @IBOutlet weak var stackPassword: UIStackView!        // StackView wrapping password field
    @IBOutlet weak var btnEyePassword: UIButton!          // Button to toggle password visibility
    @IBOutlet weak var txtPassword: UITextField!          // Password input field
    @IBOutlet weak var txtConfirmPassword: UITextField!   // Confirm password input field
    @IBOutlet weak var txtAddress: UITextField!           // Address input field
    @IBOutlet weak var txtMobileNo: UITextField!          // Mobile number input field
    @IBOutlet weak var txtName: UITextField!              // Name input field
    @IBOutlet weak var txtEmail: UITextField!             // Email input field
    @IBOutlet weak var btnBackToLogin: UIButton!          // Back to login button
    @IBOutlet weak var btnSignup: UIButton!               // Signup button
    
    // Flag to check if password is visible
    var isPasswordVisible: Bool = false
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyTheme()
        
        // Listen for theme changes
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applyTheme),
            name: NSNotification.Name("themeChanged"),
            object: nil
        )
        
        // Apply styling to all text fields and buttons
        //        let allFields = [txtName!, txtEmail!, txtAddress!, txtMobileNo!, btnSignup!, stackPassword!, stackConfirmPassword!]
        //        styleViews(allFields, cornerRadius: 28, borderWidth: 0, borderColor: UIColor.black.cgColor)
        //
                // Add padding inside text fields
                let allViews = [txtName!, txtEmail!, txtAddress!, txtMobileNo!]
                setTextFieldPadding(allViews)
        
        // Add custom padding for password fields
        txtPassword.setPadding(left: 34, right: 5)
        txtConfirmPassword.setPadding(left: 34, right: 5)
        
        // MARK: - Localization
        lblAddYOurDetailsToSignUpPage.text = Main.Signup.lblAddYourDetails
        lblSignUpTitle.text = Main.Signup.lblSignupTitle
        
        txtName.placeholder = Main.Signup.txtNamePlaceholder
        txtEmail.placeholder = Main.Signup.txtEmailPlaceholder
        txtMobileNo.placeholder = Main.Signup.txtMobilePlaceholder
        txtAddress.placeholder = Main.Signup.txtAddressPlaceholder
        txtPassword.placeholder = Main.Signup.txtPasswordPlaceholder
        txtConfirmPassword.placeholder = Main.Signup.txtConfirmPasswordPlaceholder
        
        btnSignup.setTitle(Main.Signup.btnSignup, for: .normal)
        btnBackToLogin.setTitle(Main.Signup.btnBackToLogin, for: .normal)
        btnBackToLogin.tintColor = UIColor.gray
    }
    
    @objc private func applyTheme() {
        let theme = ThemeManager.currentTheme   // ✅ No .shared
        
        // Background
        view.backgroundColor = theme.backgroundColor
        
        // Buttons
        btnSignup.backgroundColor = theme.buttonColor
        btnSignup.setTitleColor(theme.titleColor, for: .normal)
        btnSignup.layer.cornerRadius = 28
        btnSignup.clipsToBounds = true
        btnSignup.layer.borderWidth = 1
        btnSignup.layer.borderColor = theme.borderColor.cgColor
        btnBackToLogin.tintColor = theme.secondaryFontColor
        
        // TextFields Styling
        let textFields: [UITextField] = [txtName, txtEmail, txtMobileNo, txtAddress]
        for tf in textFields {
            tf.layer.cornerRadius = 28
            tf.layer.masksToBounds = true
            tf.layer.borderWidth = 1
            tf.layer.borderColor = theme.borderColor.cgColor
            tf.textColor = theme.labelColor
            tf.backgroundColor = theme.cellBackgroundColor
            
        }
        
        // StackViews (password, confirm password)
        let stacks: [UIStackView] = [stackPassword, stackConfirmPassword]
        for stack in stacks {
            stack.layer.cornerRadius = 28
            stack.layer.masksToBounds = true
            stack.layer.borderWidth = 1
            stack.layer.borderColor = theme.borderColor.cgColor
            stack.backgroundColor = theme.cellBackgroundColor
        }
    }

    
    // MARK: - Actions
    
    /// Toggle password visibility when eye button is tapped
    @IBAction func btnEyePasswordAction(_ sender: Any) {
        isPasswordVisible = !isPasswordVisible
        txtPassword.isSecureTextEntry = !isPasswordVisible
        let imageName = isPasswordVisible ? Main.images.eye : Main.images.eyeSlash
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    
    /// Toggle confirm password visibility when eye button is tapped
    @IBAction func btnEyeConfirmPasswordAction(_ sender: Any) {
        isPasswordVisible = !isPasswordVisible
        txtConfirmPassword.isSecureTextEntry = !isPasswordVisible
        let imageName = isPasswordVisible ? Main.images.eye : Main.images.eyeSlash
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    
    /// Handle signup button action with validation
    @IBAction func btnSignupAction(_ sender: Any) {
        let username = txtName.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let email = txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() ?? ""
        let password = txtPassword.text ?? ""
        let confirmPassword = txtConfirmPassword.text ?? ""
        let address = txtAddress.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let mobileNo = txtMobileNo.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        // ✅ Step 1: Validations
        //        switch true {
        //        case username.isEmpty:
        //            UIAlertController.showAlert(title: Main.AlertTitle.NameMissing, message: Main.ValidationMessages.nameMissing, viewController: self)
        //            return
        //        case email.isEmpty:
        //            UIAlertController.showAlert(title: Main.AlertTitle.EmailMissing, message: Main.ValidationMessages.emailMissing, viewController: self)
        //            return
        //        case !isValidEmail(email):
        //            UIAlertController.showAlert(title: Main.AlertTitle.InvalidEmail, message: Main.ValidationMessages.invalidEmail, viewController: self)
        //            return
        //        case mobileNo.isEmpty:
        //            UIAlertController.showAlert(title: Main.AlertTitle.MobileMissing, message: Main.ValidationMessages.mobileMissing, viewController: self)
        //            return
        //        case address.isEmpty:
        //            UIAlertController.showAlert(title: Main.AlertTitle.AddressMissing, message: Main.ValidationMessages.addressMissing, viewController: self)
        //            return
        //        case password.isEmpty:
        //            UIAlertController.showAlert(title: Main.AlertTitle.PasswordMissing, message: Main.ValidationMessages.passwordMissing, viewController: self)
        //            return
        //        case !isValidPassword(password):
        //            UIAlertController.showAlert(title: Main.AlertTitle.InvalidPassword, message: Main.ValidationMessages.invalidPassword, viewController: self)
        //            return
        //        case confirmPassword.isEmpty:
        //            UIAlertController.showAlert(title: Main.AlertTitle.ConfirmPasswordMissing, message: Main.ValidationMessages.confirmPasswordMissing, viewController: self)
        //            return
        //        case password != confirmPassword:
        //            UIAlertController.showAlert(title: Main.AlertTitle.PasswordMismatch, message: Main.ValidationMessages.passwordMismatch, viewController: self)
        //            return
        //        default: break
        //        }
        
        switch true {
        case username.isEmpty:
            showAlert(Main.Signup.alertNameMissing)
            return
        case email.isEmpty:
            showAlert(Main.Signup.alertEmailMissing)
            return
        case !isValidEmail(email):
            showAlert(Main.Signup.alertInvalidEmail)
            return
        case mobileNo.isEmpty:
            showAlert(Main.Signup.alertMobileMissing)
            return
        case address.isEmpty:
            showAlert(Main.Signup.alertAddressMissing)
            return
        case password.isEmpty:
            showAlert(Main.Signup.alertPasswordMissing)
            return
        case !isValidPassword(password):
            showAlert(Main.Signup.alertInvalidPassword)
            return
        case confirmPassword.isEmpty:
            showAlert(Main.Signup.alertConfirmPasswordMissing)
            return
        case password != confirmPassword:
            showAlert(Main.Signup.alertPasswordMismatch)
            return
        default:
            break
        }
        
        // ✅ Step 2: Save user to CoreData
        if CoreDataHelper.shared.saveUser(
            name: username,
            email: email,
            password: password,
            address: address,
            mobile: mobileNo
        ) {
            // If successful → show success and pop back to login screen
            showAlert(Main.Signup.alertSignupSuccess) {
                self.navigationController?.popViewController(animated: true)
            }
        } else {
            // If email already exists → show error
            showAlert(Main.Signup.alertUserExists)        }
    }
    
    /// Navigate back to login screen
    @IBAction func btnBackToLogin(_ sender: Any) {
        let storyboard = UIStoryboard(name: Main.storyboards.userlogin, bundle: nil)
        if ((storyboard.instantiateViewController(withIdentifier: Main.viewController.login) as? LoginViewController) != nil){
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - Helpers
    
    /// Reusable alert function
    private func showAlert(_ message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: Main.Alerts.signup, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Main.AlertTitle.okBtn, style: .default) { _ in
            completion?()
        })
        present(alert, animated: true)
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("themeChanged"), object: nil)
    }
}

// MARK: - UITextFieldDelegate
extension SignupViewController: UITextFieldDelegate {
    
    /// Handle navigation between text fields using return key
    func textFieldShouldReturn (_ textField: UITextField) -> Bool {
        if textField == txtName && textField.returnKeyType == .next {
            txtName.resignFirstResponder()
            txtEmail.becomeFirstResponder()
        }
        else if textField == txtEmail && textField.returnKeyType == .next {
            txtEmail.resignFirstResponder()
            txtMobileNo.becomeFirstResponder()
        }
        else if textField == txtMobileNo && textField.returnKeyType == .next {
            txtMobileNo.resignFirstResponder()
            txtAddress.becomeFirstResponder()
        }
        else if textField == txtAddress && textField.returnKeyType == .next {
            txtAddress.resignFirstResponder()
            txtPassword.becomeFirstResponder()
        }
        else if textField == txtPassword && textField.returnKeyType == .next {
            txtPassword.resignFirstResponder()
            txtConfirmPassword.becomeFirstResponder()
        }
        else {
            // Dismiss keyboard on last field
            txtConfirmPassword.resignFirstResponder()
        }
        return true
    }
}
