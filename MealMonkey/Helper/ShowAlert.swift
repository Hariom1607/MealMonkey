//
//  UI ShowAlert.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 14/08/25.
//

import Foundation
import UIKit

extension UIAlertController {
    
    // Show a simple alert with title, message, and "Ok" button
    class func showAlert(title: String, message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: Main.Labels.ok, style: .default, handler: { _ in
            // Action when "Ok" button is pressed (currently does nothing)
        }))
        
        viewController.present(alert, animated: true)
    }
}
