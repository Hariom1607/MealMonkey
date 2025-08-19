//
//  UI Save Card.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 13/08/25.
//

import Foundation

// Save a new card number to UserDefaults
func addNewCard(_ cardNumber: String) {
    var savedCards = UserDefaults.standard.array(forKey: "savedCards") as? [String] ?? []
    savedCards.append(cardNumber)
    UserDefaults.standard.set(savedCards, forKey: "savedCards")
}

// Get all saved card numbers from UserDefaults
func getSavedCards() -> [String] {
    return UserDefaults.standard.array(forKey: "savedCards") as? [String] ?? []
}
