//
//  LoginViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 31/07/25.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var btnEye: UIButton!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnSignup: UIButton!
    @IBOutlet weak var btnGoogleLogin: UIButton!
    @IBOutlet weak var btnFacebookLogin: UIButton!
    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    // MARK: - Properties
    var isPasswordVisible: Bool = false   // Used to toggle password visibility
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Apply rounded style to all inputs and buttons
        let allViews = [
            txtEmail!,
            txtPassword!,
            btnLogin!,
            btnSignup!,
            btnGoogleLogin!,
            btnFacebookLogin!,
            btnForgotPassword!
        ]
        styleViews(allViews, cornerRadius: 28, borderWidth: 0, borderColor: UIColor.black.cgColor)
        
        // Add padding to text fields
        txtEmail.setPadding(left: 34, right: 34)
        txtPassword.setPadding(left: 34, right: 48)
        
        // Hide tab bar on login screen
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide navigation bar for a cleaner login screen
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Navigation
    /// Switch to main TabBar after successful login
    private func showMainTabBar() {
        let storyboard = UIStoryboard(name: Main.storyboards.tabBar, bundle: nil)
        if let tabBarController = storyboard.instantiateViewController(withIdentifier: Main.viewController.menuTabBar) as? UITabBarController {
            
            // Default open tab at index 2
            tabBarController.selectedIndex = 2
            
            // Replace root view controller with TabBar
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                
                sceneDelegate.window?.rootViewController = tabBarController
                sceneDelegate.window?.makeKeyAndVisible()
            }
        }
    }
    
    // MARK: - Actions
    
    /// Handles login button tap
    @IBAction func btnLoginAction(_ sender: Any) {
        let email = txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() ?? ""
        let password = txtPassword.text ?? ""
        
        // ✅ Step 1: Validations
        switch true {
        case email.isEmpty:
            UIAlertController.showAlert(title: "Email Missing", message: "Please enter your email", viewController: self)
            return
        case !isValidEmail(email):
            UIAlertController.showAlert(title: "Invalid Email", message: "Please enter a valid email address", viewController: self)
            return
        case password.isEmpty:
            UIAlertController.showAlert(title: "Password Missing", message: "Please enter your password", viewController: self)
            return
        case !isValidPassword(password):
            UIAlertController.showAlert(title: "Invalid Password", message: "Please enter a valid password", viewController: self)
            return
        default: break
        }
        
        // Check credentials against Core Data
        if let user = CoreDataHelper.shared.verifyUser(email: email, password: password) {
            // ✅ Save login state
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            UserDefaults.standard.set(email, forKey: "currentUserEmail")
            
            if let name = user.name {
                UserDefaults.standard.set(name, forKey: "currentUserName")
            }
            UserDefaults.standard.synchronize()
            
            print("✅ Login successful: \(email)")
            // ✅ Only go to main tab bar if login succeeds
            showMainTabBar()
        }
        else {
            // 🚨 Wrong credentials
            UIAlertController.showAlert(
                title: "Login Failed",
                message: "Invalid email or password. Please sign up if you don't have an account.",
                viewController: self
            )
        }
    }
    
    /// Navigate to Forgot Password screen
    @IBAction func btnForgotPasswordAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: Main.storyboards.userlogin, bundle: nil)
        if let mlvc = storyboard.instantiateViewController(withIdentifier: Main.viewController.forgotPassword) as? ForgotPasswordViewController {
            self.navigationController?.pushViewController(mlvc, animated: true)
        }
    }
    
    /// Toggle password visibility (eye button)
    @IBAction func btnEyeAction(_ sender: Any) {
        isPasswordVisible.toggle()
        txtPassword.isSecureTextEntry = !isPasswordVisible
        
        // Change eye icon accordingly
        let imageName = isPasswordVisible ? "eye" : "eye.slash"
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    
    /// Facebook login (to be implemented)
    @IBAction func btnLoginFaceBookAction(_ sender: Any) {}
    
    /// Google login (to be implemented)
    @IBAction func btnLoginGoogleAction(_ sender: Any) {}
    
    /// Navigate to Signup screen
    @IBAction func btnSignupAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: Main.storyboards.userlogin, bundle: nil)
        if let mlvc = storyboard.instantiateViewController(withIdentifier: Main.viewController.signup) as? SignupViewController {
            self.navigationController?.pushViewController(mlvc, animated: true)
        }
    }
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    
    /// Handles return key navigation between fields
    func textFieldShouldReturn (_ textField: UITextField) -> Bool {
        if textField == txtEmail && textField.returnKeyType == .next {
            txtEmail.resignFirstResponder()
            txtPassword.becomeFirstResponder()
        } else {
            txtPassword.resignFirstResponder()
        }
        return true
    }
}
