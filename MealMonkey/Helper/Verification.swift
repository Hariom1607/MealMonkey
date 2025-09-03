//
//  UI Verification.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 04/08/25.
//

import Foundation
import UIKit

// Validate password strength: must contain uppercase, lowercase, digit, special char, min 8 chars
func isValidPassword(_ password: String) -> Bool {
    let passwordRegex = Main.ValidationPatterns.password
    let passwordPredicate = NSPredicate(format: Main.PredicateFormats.matches , passwordRegex)
    return passwordPredicate.evaluate(with: password)
}

// Validate email format
func isValidEmail(_ email: String) -> Bool {
    let trimmed = email.trimmingCharacters(in: .whitespacesAndNewlines)
    let emailRegEx = Main.ValidationPatterns.email
    let predicate = NSPredicate(format: Main.PredicateFormats.matches , emailRegEx)
    return predicate.evaluate(with: trimmed)
}
