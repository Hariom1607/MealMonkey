//
//  UI Save Card.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 13/08/25.
//

import Foundation

func addNewCard(_ cardNumber: String) {
    var savedCards = UserDefaults.standard.array(forKey: "savedCards") as? [String] ?? []
    savedCards.append(cardNumber)
    UserDefaults.standard.set(savedCards, forKey: "savedCards")
}

func getSavedCards() -> [String] {
    return UserDefaults.standard.array(forKey: "savedCards") as? [String] ?? []
}

