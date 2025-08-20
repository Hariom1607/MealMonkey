//
//  UI Corner Radius.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 01/08/25.
//

import Foundation
import UIKit

// Apply corner radius, border width, and border color to multiple views
func styleViews(_ views: [UIView], cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: CGColor) {
    for view in views {
        view.layer.cornerRadius = cornerRadius
        view.layer.borderWidth = borderWidth
        view.layer.borderColor = borderColor
    }
}

// Add left and right padding to multiple text fields
func setTextFieldPadding(_ views: [UIView], left: CGFloat = 34, right: CGFloat = 34) {
    for view in views {
        if let textField = view as? UITextField {
            textField.setPadding(left: left, right: right)
        }
    }
}

/// Helper to apply rounded corners to multiple views
func roundCorners(of views: [UIView],
                  radius: CGFloat = 18,
                  corners: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner]) {
    views.forEach { view in
        view.layer.cornerRadius = radius
        view.layer.masksToBounds = true
        view.layer.maskedCorners = corners
    }
}
