//
//  UI Corner Radius.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 01/08/25.
//

import Foundation
import UIKit

func styleViews(_ views: [UIView], cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: CGColor) {
    
    for view in views {
        view.layer.cornerRadius = cornerRadius
        view.layer.borderWidth = borderWidth
        view.layer.borderColor = borderColor
    }
}

func setTextFieldPadding(_ views: [UIView], left: CGFloat = 0, right: CGFloat = 0) {
    for view in views {
        if let textField = view as? UITextField {
            textField.setPadding(left: left, right: right)
        }
    }
}
