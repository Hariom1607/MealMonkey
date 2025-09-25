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
        
        self.navigationController?.navigationBar.isHidden = true
        
        applyTheme()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applyTheme),
            name: NSNotification.Name("themeChanged"),
            object: nil
        )
    }
    
    @objc private func applyTheme() {
        let theme = ThemeManager.currentTheme
        
        // Tab bar background
        tabBar.barTintColor = theme.backgroundColor
        tabBar.backgroundColor = theme.backgroundColor
        
        // Selected tab icon & text color
        tabBar.tintColor = theme.buttonColor
        
        // Unselected tab icon & text color
        tabBar.unselectedItemTintColor = theme.secondaryFontColor
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("themeChanged"), object: nil)
    }
}
