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
                                     textColor: UIColor = UIColor(named: "NavigationColor") ?? .black,
                                     target: Any?,
                                     action: Selector) {
        
        let backButton = UIButton(type: .system)
        backButton.tintColor = textColor
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backButton.setTitle("  \(title)", for: .normal) // space between icon & text
        backButton.setTitleColor(textColor, for: .normal)
        backButton.titleLabel?.font = font
        backButton.sizeToFit()
        backButton.addTarget(target, action: action, for: .touchUpInside)
        
        // Set as left navigation item
        let leftItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = leftItem
        
        // Ensure white navigation bar background
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.backgroundColor = .white
    }
    
    // Set navigation title (without back button)
    func setLeftAlignedTitle(_ title: String,
                             font: UIFont = .systemFont(ofSize: 29),
                             textColor: UIColor = UIColor(named: "NavigationColor") ?? .black) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = font
        titleLabel.textColor = textColor
        titleLabel.sizeToFit()
        
        let leftItem = UIBarButtonItem(customView: titleLabel)
        self.navigationItem.leftBarButtonItem = leftItem
        
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.backgroundColor = .white
    }
    
    // Add cart button on the right side of navigation bar
    func setCartButton(target: Any?, action: Selector,
                       tintColor: UIColor = UIColor(named: "NavigationColor") ?? .black) {
        let cartImage = UIImage(systemName: "cart.fill")?.withRenderingMode(.alwaysTemplate)
        let cartButton = UIBarButtonItem(image: cartImage, style: .plain, target: target, action: action)
        cartButton.tintColor = tintColor
        self.navigationItem.rightBarButtonItem = cartButton
    }
}
