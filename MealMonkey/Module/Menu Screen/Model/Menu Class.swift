//
//  Menu Class.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 05/08/25.
//

import Foundation
import UIKit

class Menu{
    
    let imageName: String?
    let strName: String
    let strQuantity: String
    
    init(imageName: String?, strName: String, strQuantity: String) {
        self.imageName = imageName
        self.strName = strName
        self.strQuantity = strQuantity
    }
    
    class func populateMenu() ->[Menu]{
        return [
            Menu(imageName: "ic_1x_FoodMenu",
                 strName: "Food",
                 strQuantity: "120 Items"),
            Menu(imageName: "ic_1x_BeveragesMenu",
                 strName: "Beverages",
                 strQuantity: "220 Items"),
            Menu(imageName: "ic_1x_DesertMenu",
                 strName: "Desserts",
                 strQuantity: "155 Items")
        ]
    }
}
