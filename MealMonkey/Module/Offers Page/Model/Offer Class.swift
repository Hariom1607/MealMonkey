//
//  Offer Class.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 06/08/25.
//

import Foundation
import UIKit

class offer: NSObject{
    let imageCafe: String
    let strCafeName: String
    let strNoOfRatings: String
    let strRestaurantType: String
    let strFoodType: String
    
    init(imageCafe: String, strCafeName: String, strNoOfRatings: String, strRestaurantType: String, strFoodType: String) {
        self.imageCafe = imageCafe
        self.strCafeName = strCafeName
        self.strNoOfRatings = strNoOfRatings
        self.strRestaurantType = strRestaurantType
        self.strFoodType = strFoodType
    }
    
    class func getAllOffers() -> [offer] {
            return [
                offer(
                    imageCafe: "ic_Café de Noires",
                    strCafeName: "Café de Noires",
                    strNoOfRatings: "(124 ratings)",
                    strRestaurantType: "Café",
                    strFoodType: "Western Food"
                ),
                offer(
                    imageCafe: "ic_Isso",
                    strCafeName: "Isso",
                    strNoOfRatings: "(124 ratings)",
                    strRestaurantType: "Café",
                    strFoodType: "Western Food"
                ),
                offer(
                    imageCafe: "ic_Cafe Beans",
                    strCafeName: "Cafe Beans",
                    strNoOfRatings: "(124 ratings)",
                    strRestaurantType: "Café",
                    strFoodType: "Western Food"
                )
            ]
        }
}
