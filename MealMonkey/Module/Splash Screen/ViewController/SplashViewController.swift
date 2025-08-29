//
//  SplashViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 31/07/25.
//

import UIKit

class SplashViewController: UIViewController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Additional setup if needed (currently unused).
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Hide navigation bar on splash screen
        self.navigationController?.navigationBar.isHidden = true
        
        // Wait 2 seconds before navigating (splash delay)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            
            // Check if user is already logged in (from UserDefaults)
            let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
            
            if isLoggedIn,
               let email = UserDefaults.standard.string(forKey: "currentUserEmail") {
                // ✅ Auto-login case
                print("✅ Auto-login user: \(email)")
                self.showMainTabBar()
            } else {
                // 🚪 Not logged in → go to Login
                self.showLogin()
            }
        }
    }
    
    // MARK: - Navigation
    
    /// Show login screen (when no active user session found)
    private func showLogin() {
        let storyboard = UIStoryboard(name: Main.storyboards.userlogin, bundle: nil)
        
        if let loginVC = storyboard.instantiateViewController(withIdentifier: Main.viewController.login) as? LoginViewController {
            
            // Replace rootViewController with Login inside a UINavigationController
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                
                let nav = UINavigationController(rootViewController: loginVC)
                sceneDelegate.window?.rootViewController = nav
                sceneDelegate.window?.makeKeyAndVisible()
            }
        }
    }
    
    /// Show main app tab bar (when user is already logged in)
    private func showMainTabBar() {
        let storyboard = UIStoryboard(name: Main.storyboards.tabBar, bundle: nil)
        
        if let tabBarController = storyboard.instantiateViewController(withIdentifier: Main.viewController.menuTabBar) as? UITabBarController {
            
            // 👉 Set the default tab (example: index 0 = Menu, index 1 = Home, etc.)
            tabBarController.selectedIndex = 2   // Change this to the index of your Home tab
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                
                UIView.transition(with: sceneDelegate.window!,
                                  duration: 0.3,
                                  options: .transitionCrossDissolve,
                                  animations: {
                    sceneDelegate.window?.rootViewController = tabBarController
                }, completion: nil)
            }
        }
    }
}
