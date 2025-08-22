//
//  ProfileViewController + Delegate.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 06/08/25.
//

import Foundation
import UIKit

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    /// Called when the user finishes picking an image from the UIImagePickerController
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.editedImage] as? UIImage {
            // Only set it temporarily
            imgUser.image = selectedImage
            // ✅ Save image to CoreData for the current user
            if let email = UserDefaults.standard.string(forKey: "currentUserEmail") {
                let imageData = selectedImage.jpegData(compressionQuality: 0.8)
                CoreDataHelper.shared.updateUser(oldEmail: email,
                                                 newEmail: email,
                                                 name: nil,
                                                 mobile: nil,
                                                 address: nil,
                                                 password: nil,
                                                 imageData: imageData)
            }
        }
        dismiss(animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension ProfileViewController: UITextFieldDelegate {
    
    /// Handles the "Return" key navigation between text fields
    func textFieldShouldReturn (_ textField: UITextField) -> Bool {
        if textField == txtName && textField.returnKeyType == .next {
            // Move focus from Name → Email
            txtName.resignFirstResponder()
            txtEmail.becomeFirstResponder()
        }
        else if textField == txtEmail && textField.returnKeyType == .next {
            // Move focus from Email → Mobile No
            txtEmail.resignFirstResponder()
            txtMobileNo.becomeFirstResponder()
        }
        else if textField == txtMobileNo && textField.returnKeyType == .next {
            // Move focus from Mobile No → Address
            txtMobileNo.resignFirstResponder()
            txtAddress.becomeFirstResponder()
        }
        else {
            // Dismiss keyboard on last field
            txtAddress.resignFirstResponder()
        }
        return true
    }
}
