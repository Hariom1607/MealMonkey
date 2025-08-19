//
//  UI Save Login.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 18/08/25.
//

import Foundation
import CoreData
import UIKit

// MARK: - Core Data Helpers

// Fetch a single user by email
func fetchUser(email: String) -> User? {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
    let context = appDelegate.persistentContainer.viewContext
    
    let request: NSFetchRequest<User> = User.fetchRequest()
    request.predicate = NSPredicate(format: "email == %@", email)
    
    do {
        let users = try context.fetch(request)
        return users.first
    } catch {
        print("Failed to fetch user:", error)
        return nil
    }
}

// Save a new user (returns false if user already exists)
func saveUser(email: String, password: String, name: String?, mobile: String?, address: String?) -> Bool {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
    let context = appDelegate.persistentContainer.viewContext
    
    if let _ = fetchUser(email: email) {
        print("User already exists")
        return false
    }
    
    let user = User(context: context)
    user.id = UUID()
    user.email = email
    user.password = password
    user.name = name
    user.mobile = mobile
    user.address = address
    
    do {
        try context.save()
        return true
    } catch {
        print("Failed to save user:", error)
        return false
    }
}

// Fetch all users
func fetchAllUsers() -> [User] {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
    let context = appDelegate.persistentContainer.viewContext
    
    let request: NSFetchRequest<User> = User.fetchRequest()
    
    do {
        return try context.fetch(request)
    } catch {
        print("Failed to fetch users:", error)
        return []
    }
}

// Update user details by email
func updateUser(email: String, name: String?, mobile: String?, address: String?, password: String?) -> Bool {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
    let context = appDelegate.persistentContainer.viewContext
    
    guard let user = fetchUser(email: email) else { return false }
    
    if let name = name { user.name = name }
    if let mobile = mobile { user.mobile = mobile }
    if let address = address { user.address = address }
    if let password = password { user.password = password }
    
    do {
        try context.save()
        return true
    } catch {
        print("Failed to update user:", error)
        return false
    }
}
