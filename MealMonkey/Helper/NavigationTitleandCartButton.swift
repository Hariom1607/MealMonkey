//
//  UI Navigation Title and Cart Button.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 05/08/25.
//

import Foundation
import UIKit

// Extension for customizing navigation bar items
extension UIViewController {
    
    // Set navigation title with back button (icon + text)
    func setLeftAlignedTitleWithBack(_ title: String,
                                     font: UIFont = .systemFont(ofSize: 29),
                                     target: Any?,
                                     action: Selector) {
        
        // Decide color based on screen
        let textColor: UIColor = (self is FoodDetailViewController) ? .white :
        (UIColor(named: Main.Colors.navigationcolor) ?? .black)
        
        let backButton = UIButton(type: .system)
        backButton.tintColor = textColor
        backButton.setImage(UIImage(systemName: Main.Colors.navigationBackBtnColor), for: .normal)
        backButton.setTitle("  \(title)", for: .normal) // space between icon & text
        backButton.setTitleColor(textColor, for: .normal)
        backButton.titleLabel?.font = font
        backButton.sizeToFit()
        backButton.addTarget(target, action: action, for: .touchUpInside)
        
        // Set as left navigation item
        let leftItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = leftItem
        
        // Nav bar background handling
        if self is FoodDetailViewController {
            // Transparent nav bar
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.navigationBar.backgroundColor = .clear
        } else {
            // White nav bar
            self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
            self.navigationController?.navigationBar.shadowImage = nil
            self.navigationController?.navigationBar.isTranslucent = false
            self.navigationController?.navigationBar.backgroundColor = .white
        }
    }
    
    // Set navigation title (without back button)
    func setLeftAlignedTitle(_ title: String,
                             font: UIFont = .systemFont(ofSize: 29)) {
        
        // Decide color based on screen
        let textColor: UIColor = (self is FoodDetailViewController) ? .white :
        (UIColor(named: Main.Colors.navigationcolor) ?? .black)
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = font
        titleLabel.textColor = textColor
        titleLabel.sizeToFit()
        
        let leftItem = UIBarButtonItem(customView: titleLabel)
        self.navigationItem.leftBarButtonItem = leftItem
        
        if self is FoodDetailViewController {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.navigationBar.backgroundColor = .clear
        } else {
            self.navigationController?.navigationBar.barTintColor = .white
            self.navigationController?.navigationBar.backgroundColor = .white
        }
    }
    
    // Add cart button on the right side of navigation bar
    func setCartButton(target: Any?, action: Selector) {
        let tintColor: UIColor = (self is FoodDetailViewController) ? .white :
        (UIColor(named: Main.Colors.navigationcolor) ?? .black)
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: Main.images.cartFill)?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = tintColor
        button.addTarget(target, action: action, for: .touchUpInside)
        
        // ✅ Slightly larger button so badge has room
        button.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
        
        // ✅ Badge (smaller than before, circle by default)
        let badgeLabel = UILabel(frame: CGRect(x: 22, y: -4, width: 24, height: 24))
        badgeLabel.tag = 999
        badgeLabel.backgroundColor = .systemRed
        badgeLabel.textColor = .white
        badgeLabel.font = UIFont.systemFont(ofSize: 11, weight: .bold)
        badgeLabel.textAlignment = .center
        badgeLabel.layer.cornerRadius = 12
        badgeLabel.clipsToBounds = true
        badgeLabel.isHidden = true
        button.addSubview(badgeLabel)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        
        updateCartBadge()
    }
    
    func updateCartBadge() {
        guard let btn = self.navigationItem.rightBarButtonItem?.customView as? UIButton,
              let badge = btn.viewWithTag(999) as? UILabel else { return }
        
        if let email = UserDefaults.standard.string(forKey: Main.UserDefaultsKeys.currentUserEmail) {
            let cartItems = CoreDataHelper.shared.fetchCart(for: email)
            let totalQty = cartItems.reduce(0) { $0 + $1.quantity }
            
            if totalQty > 0 {
                badge.isHidden = false
                
                if totalQty <= 99 {
                    // ✅ Show exact qty (circle)
                    badge.text = "\(totalQty)"
                } else {
                    // ✅ Always "99+" if more than 99 (still circle)
                    badge.text = "99+"
                }
                
            } else {
                badge.isHidden = true
            }
        }
    }
}
