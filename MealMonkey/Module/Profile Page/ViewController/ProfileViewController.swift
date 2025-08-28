//
//  ProfileViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 06/08/25.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var viewImg: UIView!             // View container for user profile image
    @IBOutlet weak var txtAddress: UITextField!     // Address input field
    @IBOutlet weak var txtMobileNo: UITextField!    // Mobile number input field
    @IBOutlet weak var txtEmail: UITextField!       // Email input field
    @IBOutlet weak var txtName: UITextField!        // Name input field
    @IBOutlet weak var btnSaveUser: UIButton!       // Save button for profile changes
    @IBOutlet weak var btnSignOut: UIButton!        // Sign out button
    @IBOutlet weak var lblWelcomeMsg: UILabel!      // Welcome message label
    @IBOutlet weak var btnEditProfile: UIButton!    // Edit profile button (currently unused)
    @IBOutlet weak var imgUser: UIImageView!        // User profile image
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        self.updateCartBadge()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load saved user data from UserDefaults into textfields
        txtName.text = UserDefaults.standard.string(forKey: "userName")
        txtEmail.text = UserDefaults.standard.string(forKey: "userEmail")
        txtMobileNo.text = UserDefaults.standard.string(forKey: "userMobile")
        txtAddress.text = UserDefaults.standard.string(forKey: "userAddress")
        
        // Update welcome message
        if let name = UserDefaults.standard.string(forKey: "userName") {
            lblWelcomeMsg.text = "Welcome, \(name)"
        }
        
        // Set navigation bar title & cart button
        setLeftAlignedTitle("Profile")
        setCartButton(target: self, action: #selector(profileCartBtn))
        
        // Round profile image container
        viewImg.layer.cornerRadius = viewImg.frame.size.width/2
        viewImg.layer.borderWidth = 2
        viewImg.clipsToBounds = true
        
        // Apply styling to textfields and save button
        let allViews = [txtName!, txtEmail!, txtAddress!, txtMobileNo!, btnSaveUser!]
        styleViews(allViews, cornerRadius: 28, borderWidth: 0, borderColor: UIColor.black.cgColor)
        
        // Add left padding to textfields
        setTextFieldPadding(allViews, left: 34)
        
        // Enable profile image tap gesture to open image picker
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        imgUser.addGestureRecognizer(tapGesture)
        
        // Load user profile from CoreData or UserDefaults
        loadUserProfile()
    }
    
    // MARK: - Load Profile
    /// Loads the profile of the current logged-in user from CoreData or UserDefaults
    func loadUserProfile() {
        guard let email = UserDefaults.standard.string(forKey: "currentUserEmail"),
              let user = CoreDataHelper.shared.fetchUser(email: email) else { return }
        
        txtName.text = user.name
        txtEmail.text = user.email
        txtMobileNo.text = user.mobile
        txtAddress.text = user.address
        
        lblWelcomeMsg.text = "Welcome, \(user.name ?? "")"
        
        // ✅ Load profile image directly from CoreData
        if let imageData = user.imageData {
            imgUser.image = UIImage(data: imageData)
        } else {
            imgUser.image = UIImage(systemName: "person.crop.circle") // fallback
            imgUser.tintColor = .gray
        }
    }
    
    // MARK: - Navigation Buttons
    /// Navigates to the Cart screen
    @objc func profileCartBtn() {
        let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            self.navigationController?.pushViewController(menuVC, animated: true)
        }
    }
    
    // MARK: - Image Picker
    /// Opens image picker to select/update profile image
    @objc func openImagePicker() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    // MARK: - Button Actions
    /// Edit Profile button action (currently empty implementation)
    @IBAction func btnEditProfileAction(_ sender: Any) {
    }
    
    /// Sign Out button action
    @IBAction func btnSignOutAction(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "currentUserEmail")
        defaults.set(false, forKey: "isLoggedIn") // ✅ Mark user as logged out
        defaults.synchronize()
        
        // Navigate back to login screen
        let storyboard = UIStoryboard(name: "UserLoginStoryboard", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        let navController = UINavigationController(rootViewController: loginVC)
        navController.navigationBar.isHidden = true
        
        // Replace rootViewController with login screen
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate {
            sceneDelegate.window?.rootViewController = navController
            sceneDelegate.window?.makeKeyAndVisible()
        }
    }
    
    /// Save User button action → Updates user info in CoreData and UserDefaults
    @IBAction func btnSaveUserAction(_ sender: Any) {
        guard let oldEmail = UserDefaults.standard.string(forKey: "currentUserEmail") else { return }
        
        // Collect updated user details
        let name = txtName.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let newEmail = txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let mobile = txtMobileNo.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let address = txtAddress.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let imageData = imgUser.image?.jpegData(compressionQuality: 0.8)
        
        // ✅ Specific check for empty email
        if newEmail.isEmpty {
            let alert = UIAlertController(title: "Validation Error",
                                          message: "Email cannot be empty.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                // Restore the old email into textfield
                self.txtEmail.text = oldEmail
            }))
            self.present(alert, animated: true)
            return
        }
        
        // ✅ General empty field validation
        if name.isEmpty || mobile.isEmpty || address.isEmpty {
            UIAlertController.showAlert(title: "Validation Error",
                                        message: "All fields must be filled before saving.",
                                        viewController: self)
            return
        }
        
        // ✅ Email uniqueness validation
        if newEmail != oldEmail &&
            CoreDataHelper.shared.isEmailTaken(newEmail, excluding: oldEmail) {
            
            UIAlertController.showAlert(title: "Error",
                                        message: "This email is already registered. Please use another one.",
                                        viewController: self)
            return
        }
        
        // ✅ Proceed with CoreData update
        if CoreDataHelper.shared.updateUser(oldEmail: oldEmail,
                                            newEmail: newEmail,
                                            name: name,
                                            mobile: mobile,
                                            address: address,
                                            password: nil,
                                            imageData: imageData) {
            // ✅ Update UserDefaults
            let defaults = UserDefaults.standard
            defaults.set(name, forKey: "userName")
            defaults.set(newEmail, forKey: "userEmail")
            defaults.set(mobile, forKey: "userMobile")
            defaults.set(address, forKey: "userAddress")
            defaults.set(newEmail, forKey: "currentUserEmail")
            defaults.synchronize()
            
            // Refresh UI
            loadUserProfile()
            UIAlertController.showAlert(title: "Success", message: "Profile updated successfully!", viewController: self)
        } else {
            UIAlertController.showAlert(title: "Error", message: "Failed to update profile.", viewController: self)
        }
    }
}
