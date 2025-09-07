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
        
        // Update navigation title
        setLeftAlignedTitle(Localized("label_profile_nav_title"))
        
        // Update placeholders (localized)
        txtName.placeholder = Localized("label_profile_name_placeholder")
        txtEmail.placeholder = Localized("label_profile_email_placeholder")
        txtMobileNo.placeholder = Localized("label_profile_mobile_placeholder")
        txtAddress.placeholder = Localized("label_profile_address_placeholder")
        
        // Update buttons
        btnSaveUser.setTitle(Localized("label_profile_btn_save"), for: .normal)
        btnSignOut.setTitle(Localized("label_profile_btn_signout"), for: .normal)
        btnEditProfile.setTitle(Localized("label_profile_btn_edit"), for: .normal)
        
        // Update user data from UserDefaults/CoreData
        loadUserProfile()
        
        // Update welcome message dynamically
        if let name = UserDefaults.standard.string(forKey: Main.UserDefaultsKeys.userName), !name.isEmpty {
            lblWelcomeMsg.text = String(format: Localized("label_profile_welcome"), name)
        } else {
            lblWelcomeMsg.text = String(format: Localized("label_profile_welcome"), "")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ✅ Localized placeholders
        txtName.placeholder = Main.Labels.profileNamePlaceholder
        txtEmail.placeholder = Main.Labels.profileEmailPlaceholder
        txtMobileNo.placeholder = Main.Labels.profileMobilePlaceholder
        txtAddress.placeholder = Main.Labels.profileAddressPlaceholder
        
        // ✅ Localized buttons
        btnSaveUser.setTitle(Main.Labels.profileBtnSave, for: .normal)
        btnSignOut.setTitle(Main.Labels.profileBtnSignOut, for: .normal)
        btnEditProfile.setTitle(Main.Labels.profileBtnEdit, for: .normal)
        
        // Load saved user data from UserDefaults into textfields
        txtName.text = UserDefaults.standard.string(forKey: Main.UserDefaultsKeys.userName)
        txtEmail.text = UserDefaults.standard.string(forKey: Main.UserDefaultsKeys.userName)
        txtMobileNo.text = UserDefaults.standard.string(forKey: Main.UserDefaultsKeys.userMobile)
        txtAddress.text = UserDefaults.standard.string(forKey: Main.UserDefaultsKeys.userAddress)
        
        // Update welcome message
        if let name = UserDefaults.standard.string(forKey: Main.UserDefaultsKeys.userName) {
            lblWelcomeMsg.text = "Welcome, \(name)"
        }
        
        // Set navigation bar title & cart button
        setLeftAlignedTitle(Main.Labels.profileNavTitle)
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
        
        // ✅ Welcome message
        if let name = UserDefaults.standard.string(forKey: Main.UserDefaultsKeys.userName), !name.isEmpty {
            lblWelcomeMsg.text = String(format: Main.Labels.profileWelcome, name)
        } else {
            lblWelcomeMsg.text = String(format: Main.Labels.profileWelcome, "")
        }
        
        // Load user profile from CoreData or UserDefaults
        loadUserProfile()
    }
    
    // MARK: - Load Profile
    /// Loads the profile of the current logged-in user from CoreData or UserDefaults
    func loadUserProfile() {
        guard let email = UserDefaults.standard.string(forKey: Main.UserDefaultsKeys.currentUserEmail),
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
            imgUser.image = UIImage(systemName: Main.images.defaultUser) // fallback
            imgUser.tintColor = .gray
        }
    }
    
    // MARK: - Navigation Buttons
    /// Navigates to the Cart screen
    @objc func profileCartBtn() {
        let storyboard = UIStoryboard(name: Main.storyboards.menu, bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: Main.viewController.cart) as? CartViewController {
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
        defaults.removeObject(forKey: Main.UserDefaultsKeys.currentUserEmail)
        defaults.set(false, forKey: Main.UserDefaultsKeys.isLoggedIn) // ✅ Mark user as logged out
        defaults.synchronize()
        
        // Navigate back to login screen
        let storyboard = UIStoryboard(name: Main.storyboards.userlogin, bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: Main.viewController.login)
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
        guard let oldEmail = UserDefaults.standard.string(forKey: Main.UserDefaultsKeys.currentUserEmail) else { return }
        
        // Collect updated user details
        let name = txtName.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let newEmail = txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let mobile = txtMobileNo.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let address = txtAddress.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let imageData = imgUser.image?.jpegData(compressionQuality: 0.8)
        
        // ✅ Specific check for empty email
        if newEmail.isEmpty {
            let alert = UIAlertController(title: Main.Alerts.validationError,
                                          message: Main.Messages.emailEmpty,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: Main.AlertTitle.okBtn, style: .default, handler: { _ in
                // Restore the old email into textfield
                self.txtEmail.text = oldEmail
            }))
            self.present(alert, animated: true)
            return
        }
        
        // ✅ General empty field validation
        if name.isEmpty || mobile.isEmpty || address.isEmpty {
            UIAlertController.showAlert(title: Main.Alerts.validationError,
                                        message: Main.Messages.emptyFields,
                                        viewController: self)
            return
        }
        
        // ✅ Email uniqueness validation
        if newEmail != oldEmail &&
            CoreDataHelper.shared.isEmailTaken(newEmail, excluding: oldEmail) {
            
            UIAlertController.showAlert(title: Main.Alerts.error,
                                        message: Main.Messages.emailExists,
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
            defaults.set(name, forKey: Main.UserDefaultsKeys.userName)
            defaults.set(newEmail, forKey: Main.UserDefaultsKeys.userEmail)
            defaults.set(mobile, forKey: Main.UserDefaultsKeys.userMobile)
            defaults.set(address, forKey: Main.UserDefaultsKeys.userAddress)
            defaults.set(newEmail, forKey: Main.UserDefaultsKeys.currentUserEmail)
            defaults.synchronize()
            
            // Refresh UI
            loadUserProfile()
            UIAlertController.showAlert(title: Main.Alerts.success, message: Main.Messages.profileUpdated, viewController: self)
        } else {
            UIAlertController.showAlert(title: Main.Alerts.error, message: Main.Messages.profileUpdateFailed, viewController: self)
        }
    }
}
