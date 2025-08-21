//
//  Card+CoreDataProperties.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 21/08/25.
//
//

import Foundation
import CoreData


extension Card {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var cardNumber: String?
    @NSManaged public var firstName: String?
    @NSManaged public var expiryMonth: Int16
    @NSManaged public var expiryYear: Int16
    @NSManaged public var lastName: String?
    @NSManaged public var user: User?

}

extension Card : Identifiable {

}
