//
//  Food_Items+CoreDataProperties.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 17/08/25.
//
//

import Foundation
import CoreData


extension Food_Items {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Food_Items> {
        return NSFetchRequest<Food_Items>(entityName: "Food_Items")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var category: String?
    @NSManaged public var imageName: String?
    @NSManaged public var orders: NSSet?
    @NSManaged public var quantity: Int16
    @NSManaged public var productDescription: String?

}

// MARK: Generated accessors for orders
extension Food_Items {

    @objc(addOrdersObject:)
    @NSManaged public func addToOrders(_ value: Order)

    @objc(removeOrdersObject:)
    @NSManaged public func removeFromOrders(_ value: Order)

    @objc(addOrders:)
    @NSManaged public func addToOrders(_ values: NSSet)

    @objc(removeOrders:)
    @NSManaged public func removeFromOrders(_ values: NSSet)

}

extension Food_Items : Identifiable {

}
