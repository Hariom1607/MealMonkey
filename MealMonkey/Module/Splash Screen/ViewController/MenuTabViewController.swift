//
//  MenuTabViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 04/08/25.
//

import UIKit

// MARK: - Main Tab Bar Controller
class MenuTabViewController: UITabBarController {

    // Outlet to reference the custom tab bar from storyboard
    @IBOutlet weak var customTabBar: UITabBar!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide navigation bar since we are using a Tab Bar as the root navigation element
        self.navigationController?.navigationBar.isHidden = true

        // Additional customization for tab bar can be done here
        // Example: setting tintColor, backgroundColor, icons, etc.
    }
}
