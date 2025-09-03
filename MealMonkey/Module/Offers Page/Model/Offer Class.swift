//
//  Offer.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 06/08/25.
//

import Foundation
import UIKit

/// Model representing a restaurant offer
class Offer: NSObject {
    
    // MARK: - Properties
    let imageCafe: String          // Image name for the café/restaurant
    let cafeName: String           // Name of the café/restaurant
    let noOfRatings: String        // Number of ratings (as a string for display)
    let restaurantType: String     // Type of restaurant (e.g., Café, Fast Food)
    let foodType: String           // Type of food offered (e.g., Western, Asian)
    
    // MARK: - Initializer
    init(imageCafe: String, cafeName: String, noOfRatings: String, restaurantType: String, foodType: String) {
        self.imageCafe = imageCafe
        self.cafeName = cafeName
        self.noOfRatings = noOfRatings
        self.restaurantType = restaurantType
        self.foodType = foodType
    }
    
    // MARK: - Static Data
    /// Returns a mock list of offers (for demo/testing)
    class func getAllOffers() -> [Offer] {
        return [
            Offer(
                imageCafe: Main.Offers.cafeDeNoiresImage,
                cafeName: Main.Offers.cafeDeNoiresName,
                noOfRatings: Main.Offers.defaultRatings,
                restaurantType: Main.Offers.defaultRestaurantType,
                foodType: Main.Offers.defaultFoodType
            ),
            Offer(
                imageCafe: Main.Offers.issoImage,
                cafeName: Main.Offers.issoName,
                noOfRatings: Main.Offers.defaultRatings,
                restaurantType: Main.Offers.defaultRestaurantType,
                foodType: Main.Offers.defaultFoodType
            ),
            Offer(
                imageCafe: Main.Offers.cafeBeansImage,
                cafeName: Main.Offers.cafeBeansName,
                noOfRatings: Main.Offers.defaultRatings,
                restaurantType: Main.Offers.defaultRestaurantType,
                foodType: Main.Offers.defaultFoodType
            )
        ]
    }
}
