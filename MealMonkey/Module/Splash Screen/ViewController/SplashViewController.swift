//
//  SplashViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 31/07/25.
//

import UIKit

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
            if isLoggedIn, let email = UserDefaults.standard.string(forKey: "currentUserEmail") {
                print("✅ Auto-login user: \(email)")
                self.showMainTabBar()
            } else {
                self.showLogin()
            }
        }
    }
    
    private func showLogin() {
        let storyboard = UIStoryboard(name: "UserLoginStoryboard", bundle: nil)
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                
                let nav = UINavigationController(rootViewController: loginVC)
                sceneDelegate.window?.rootViewController = nav
                sceneDelegate.window?.makeKeyAndVisible()
            }
        }
    }
    
    private func showMainTabBar() {
        let storyboard = UIStoryboard(name: "TabBarStoryboard", bundle: nil)
        if let tabBarController = storyboard.instantiateViewController(withIdentifier: "MenuTabViewController") as? UITabBarController {
            
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
