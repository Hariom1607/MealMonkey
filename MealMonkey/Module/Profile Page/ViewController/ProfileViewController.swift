//
//  ProfileViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 06/08/25.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var viewImg: UIView!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
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
        
        setLeftAlignedTitle("Profile")
        setCartButton(target: self, action: #selector(profileCartBtn))
        
        viewImg.layer.cornerRadius = viewImg.frame.size.width/2
        viewImg.layer.borderWidth = 2
//        viewImg.layer.borderColor = UIColor.loginButton.cgColor
        viewImg.clipsToBounds = true
        
        let allViews = [txtName!, txtEmail!, txtAddress!, txtPassword!, txtMobileNo!, txtConfirmPassword!, btnSaveUser!]
        styleViews(allViews, cornerRadius: 28, borderWidth: 0, borderColor: UIColor.black.cgColor)
        
        setTextFieldPadding(allViews, left: 34)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        imgUser.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func profileCartBtn() {
        
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
    }
    
    @IBAction func btnSaveUserAction(_ sender: Any) {
    }
    
}

