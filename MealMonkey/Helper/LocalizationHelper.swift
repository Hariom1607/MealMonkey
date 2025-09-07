import Foundation
import UIKit

class LocalizationManager {
    static let shared = LocalizationManager()
    
    private let languageKey = "AppLanguage"
    
    /// Current language of the app
    var currentLanguage: String {
        return UserDefaults.standard.string(forKey: languageKey) ?? "en"
    }
    
    /// Change language
    func setLanguage(_ languageCode: String) {
        UserDefaults.standard.set(languageCode, forKey: languageKey)
        UserDefaults.standard.synchronize()
    }
    
    /// Get bundle for the selected language
    var bundle: Bundle {
        if let path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj"),
           let langBundle = Bundle(path: path) {
            return langBundle
        }
        return Bundle.main // fallback
    }
    
    /// Reset root controller
    func resetRootControllerToInitial() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate,
              let window = sceneDelegate.window else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let rootVC = storyboard.instantiateInitialViewController() {
            window.rootViewController = rootVC
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil)
        }
    }
}
