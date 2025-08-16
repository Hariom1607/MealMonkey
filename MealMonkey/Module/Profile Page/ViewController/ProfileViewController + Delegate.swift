//
//  ProfileViewController + Delegate.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 06/08/25.
//

import Foundation
import UIKit

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imgUser.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        dismiss(animated: true)
    }
}

extension ProfileViewController: UITextFieldDelegate {
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
        else{
            txtAddress.resignFirstResponder()
        }
        return true
    }
}
