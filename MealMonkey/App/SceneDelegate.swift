//
//  SceneDelegate.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 31/07/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?   // The main window of the app
    
    // MARK: - Scene Setup
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        // Load the Splash storyboard
        let storyboard = UIStoryboard(name: Main.storyboards.main, bundle: nil) // 👈 Replace "Main" with the storyboard that contains SplashViewController
        let splashVC = storyboard.instantiateViewController(withIdentifier: Main.viewController.splash) as! SplashViewController
        
        // Set Splash as the first screen
        window?.rootViewController = splashVC
        window?.makeKeyAndVisible()
    }
    
    // MARK: - Scene Lifecycle Methods
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called when the scene is being released by the system.
        // Happens when app goes into background OR scene is discarded.
        // Use this to release resources.
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the app scene becomes active (foreground).
        // Resume tasks that were paused while inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the app scene is about to move from active → inactive.
        // Example: phone call, notification interruption.
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called when the app scene transitions from background → foreground.
        // Undo changes made while in background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called when the app transitions from foreground → background.
        // Save data, release shared resources, and store scene state if needed.
    }
}
