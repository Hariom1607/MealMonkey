//
//  UI Navigation Title and Cart Button.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 05/08/25.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setLeftAlignedTitleWithBack(_ title: String, font: UIFont = .systemFont(ofSize: 29), textColor: UIColor = UIColor(named: "NavigationColor") ?? .black, target: Any?, action: Selector) {
        
        // Create button with image and text
        let backButton = UIButton(type: .system)
        backButton.tintColor = textColor
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backButton.setTitle("  \(title)", for: .normal) // space for padding between icon and text
        backButton.setTitleColor(textColor, for: .normal)
        backButton.titleLabel?.font = font
        backButton.sizeToFit()
        backButton.addTarget(target, action: action, for: .touchUpInside)
        
        // Set as left bar button item
        let leftItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = leftItem

        // Optional: Make sure navigation bar background is white
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.backgroundColor = .white
    }


    func setLeftAlignedTitle(_ title: String, font: UIFont = .systemFont(ofSize: 29), textColor: UIColor = UIColor(named: "NavigationColor") ?? .black) {
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
    
    func setCartButton(target: Any?, action: Selector, tintColor: UIColor = UIColor(named: "NavigationColor") ?? .black) {
        let cartImage = UIImage(systemName: "cart.fill")?.withRenderingMode(.alwaysTemplate)
        let cartButton = UIBarButtonItem(image: cartImage, style: .plain, target: target, action: action)
        cartButton.tintColor = tintColor
        self.navigationItem.rightBarButtonItem = cartButton
    }
}


