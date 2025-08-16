//
//  More Class.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 04/08/25.
//

import Foundation
import UIKit

class More: NSObject{
    
    let imgSection: UIImage?
    let title: String
    
    init(imgSection: String, title: String) {
        self.imgSection = UIImage(named: imgSection)
        self.title = title
    }
    
    static let items: [More] = [
        More(imgSection: "ic_1x_PaymentDetails",
             title: "Payment Details"),
        More(imgSection: "ic_1x_MyOrders",
             title: "My Orders"),
        More(imgSection: "ic_1x_Notifications",
             title: "Notifications"),
        More(imgSection: "ic_1x_Inbox",
             title: "Inbox"),
        More(imgSection: "heart",
             title: "Wishlist"),
        More(imgSection: "ic_1x_aboutus",
             title: "About Us")
    ]
}
