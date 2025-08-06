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
