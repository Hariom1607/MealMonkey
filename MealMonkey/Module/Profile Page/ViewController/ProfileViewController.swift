//
//  ProfileViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 06/08/25.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var viewImg: UIView!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtMobileNo: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var btnSaveUser: UIButton!
    @IBOutlet weak var btnSignOut: UIButton!
    @IBOutlet weak var lblWelcomeMsg: UILabel!
    @IBOutlet weak var btnEditProfile: UIButton!
    @IBOutlet weak var imgUser: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtName.text = UserDefaults.standard.string(forKey: "userName")
        txtEmail.text = UserDefaults.standard.string(forKey: "userEmail")
        txtMobileNo.text = UserDefaults.standard.string(forKey: "userMobile")
        txtAddress.text = UserDefaults.standard.string(forKey: "userAddress")
        
        if let name = UserDefaults.standard.string(forKey: "userName") {
            lblWelcomeMsg.text = "Welcome, \(name)"
        }
        
        setLeftAlignedTitle("Profile")
        setCartButton(target: self, action: #selector(profileCartBtn))
        
        viewImg.layer.cornerRadius = viewImg.frame.size.width/2
        viewImg.layer.borderWidth = 2
        viewImg.clipsToBounds = true
        
        let allViews = [txtName!, txtEmail!, txtAddress!, txtMobileNo!, btnSaveUser!]
        styleViews(allViews, cornerRadius: 28, borderWidth: 0, borderColor: UIColor.black.cgColor)
        
        setTextFieldPadding(allViews, left: 34)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        imgUser.addGestureRecognizer(tapGesture)
        
        loadUserProfile()
        
    }
    
    func loadUserProfile() {
        guard let email = UserDefaults.standard.string(forKey: "currentUserEmail"),
              let user = CoreDataHelper.shared.fetchUser(email: email) else { return }
        
        txtName.text = user.name
        txtEmail.text = user.email
        txtMobileNo.text = user.mobile
        txtAddress.text = user.address
        
        lblWelcomeMsg.text = "Welcome, \(user.name ?? "")"
        
        if let imageData = user.imageData {
            imgUser.image = UIImage(data: imageData)
        } else if let savedImageData = UserDefaults.standard.data(forKey: "userImage") {
            imgUser.image = UIImage(data: savedImageData)
        }
    }
    
    @objc func profileCartBtn() {
        let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController{
            self.navigationController?.pushViewController(menuVC, animated: true)
        }
    }
    
    @objc func openImagePicker() {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
        
    }
    
    @IBAction func btnEditProfileAction(_ sender: Any) {
    }
    
    @IBAction func btnSignOutAction(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "currentUserEmail")
        defaults.set(false, forKey: "isLoggedIn") // ✅ Mark user as logged out
        defaults.synchronize()
        
        // Go back to login screen
        let storyboard = UIStoryboard(name: "UserLoginStoryboard", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        let navController = UINavigationController(rootViewController: loginVC)
        navController.navigationBar.isHidden = true
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate {
            sceneDelegate.window?.rootViewController = navController
            sceneDelegate.window?.makeKeyAndVisible()
        }
    }
    
    @IBAction func btnSaveUserAction(_ sender: Any) {
        guard let email = UserDefaults.standard.string(forKey: "currentUserEmail") else { return }
        
        let name = txtName.text
        let mobile = txtMobileNo.text
        let address = txtAddress.text
        let imageData = imgUser.image?.jpegData(compressionQuality: 0.8)
        
        if CoreDataHelper.shared.updateUser(email: email,
                                            name: name,
                                            mobile: mobile,
                                            address: address,
                                            password: nil,
                                            imageData: imageData) {
            
            let defaults = UserDefaults.standard
            defaults.set(name, forKey: "userName")
            defaults.set(mobile, forKey: "userMobile")
            defaults.set(address, forKey: "userAddress")
            if let imageData = imageData {
                defaults.set(imageData, forKey: "userImage")
            }
            defaults.synchronize()
            
            loadUserProfile() // ✅ refresh UI
            UIAlertController.showAlert(title: "Success", message: "Profile updated successfully!", viewController: self)
        } else {
            UIAlertController.showAlert(title: "Error", message: "Failed to update profile.", viewController: self)
        }
    }
}

