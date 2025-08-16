//
//  UI ShowAlert.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 14/08/25.
//

import Foundation
import UIKit

extension UIAlertController {
    class func showAlert(title: String, message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {_ in
            
        }))
        
        viewController.present(alert, animated: true)
    }
}

