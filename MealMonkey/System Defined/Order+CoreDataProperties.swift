//
//  Order+CoreDataProperties.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 17/08/25.
//
//

import Foundation
import CoreData


extension Order {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
        return NSFetchRequest<Order>(entityName: "Order")
    }

    @NSManaged public var order_no: Int32
    @NSManaged public var product_name: String?
    @NSManaged public var total_price: Double
    @NSManaged public var users: User?
    @NSManaged public var products: NSSet?

}

// MARK: Generated accessors for products
extension Order {

    @objc(addProductsObject:)
    @NSManaged public func addToProducts(_ value: Food_Items)

    @objc(removeProductsObject:)
    @NSManaged public func removeFromProducts(_ value: Food_Items)

    @objc(addProducts:)
    @NSManaged public func addToProducts(_ values: NSSet)

    @objc(removeProducts:)
    @NSManaged public func removeFromProducts(_ values: NSSet)

}

extension Order : Identifiable {

}
