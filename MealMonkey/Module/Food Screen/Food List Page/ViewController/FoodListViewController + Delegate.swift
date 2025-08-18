//
//  FoodListViewController + Delegate.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 10/08/25.
//

import Foundation
import UIKit
import CoreData

extension FoodScreenViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4 // one collection view per section
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodListTableViewCell", for: indexPath) as! FoodListTableViewCell
        cell.delegate = self
        
        if let layout = cell.collViewFood.collectionViewLayout as? UICollectionViewFlowLayout {
            if indexPath.row == 0 || indexPath.row == 2 {
                layout.scrollDirection = .horizontal
            } else {
                layout.scrollDirection = .vertical
            }
            cell.collViewFood.collectionViewLayout.invalidateLayout()
        }
        
        switch indexPath.row {
        case 0:
            cell.collectionType = .category
            cell.selectedCategory = selectedCategory
            cell.categories = filteredCategories
            cell.lblCollViewHeading.isHidden = true
            cell.btnViewAll.isHidden = true
            cell.collViewHeight.constant = 113 // fixed
            
        case 1:
            cell.collectionType = .popular
            cell.lblCollViewHeading.isHidden = false
            cell.btnViewAll.isHidden = false
            cell.lblCollViewHeading.text = "Popular"
            if selectedCategory == .All {
                cell.products = filteredProducts.filter { $0.floatProductRating >= 4.0 && $0.floatProductRating < 4.5 }
            } else {
                cell.products = arrProductData.filter {
                    $0.floatProductRating >= 4.0 &&
                    $0.floatProductRating < 4.5 &&
                    $0.objProductCategory == selectedCategory
                }
            }
            cell.collViewHeight.constant = cell.collViewFood.collectionViewLayout.collectionViewContentSize.height
            
        case 2:
            cell.collectionType = .mostPopular
            cell.lblCollViewHeading.isHidden = false
            cell.btnViewAll.isHidden = false
            cell.lblCollViewHeading.text = "Most Popular"
            cell.collViewHeight.constant = 185
            if selectedCategory == .All {
                cell.products = filteredProducts.filter { $0.floatProductRating >= 4.5 && $0.floatProductRating <= 5.0 }
            } else {
                cell.products = arrProductData.filter {
                    $0.floatProductRating >= 4.5 &&
                    $0.floatProductRating <= 5.0 &&
                    $0.objProductCategory == selectedCategory
                }
            }
            
        case 3:
            cell.collectionType = .RecentItems
            cell.lblCollViewHeading.isHidden = false
            cell.btnViewAll.isHidden = false
            cell.lblCollViewHeading.text = "Recent Items"
            cell.products = recentItems
            cell.collViewHeight.constant = cell.collViewFood.collectionViewLayout.collectionViewContentSize.height
            
        default:
            break
        }
        
        cell.collViewFood.reloadData()
        DispatchQueue.main.async {
            cell.collViewFood.layoutIfNeeded()
            cell.updateCollectionHeight()
        }
        return cell
    }
    
    func saveOrderForCurrentUser(products: [ProductModel]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        // Fetch current user email
        guard let currentUserEmail = UserDefaults.standard.string(forKey: "currentUser") else { return }
        
        // Fetch the User object from Core Data
        let userFetch: NSFetchRequest<User> = User.fetchRequest()
        userFetch.predicate = NSPredicate(format: "email == %@", currentUserEmail)
        
        do {
            let users = try context.fetch(userFetch)
            let user: User
            
            if let existingUser = users.first {
                user = existingUser
            } else {
                // Create user if not exist (rare case)
                user = User(context: context)
                user.id = UUID()
                user.email = currentUserEmail
                user.name = UserDefaults.standard.string(forKey: "userName")
            }
            
            // Create new Order
            let order = Order(context: context)
            order.order_no = Int32((user.orders?.count ?? 0) + 1)
            order.total_price = products.reduce(0.0) { $0 + ($1.doubleProductPrice * Double($1.intProductQty ?? 1)) }
            order.users = user
            
            // Add products to order
            for prod in products {
                let foodItemFetch: NSFetchRequest<Food_Items> = Food_Items.fetchRequest()
                foodItemFetch.predicate = NSPredicate(format: "name == %@", prod.strProductName)
                let fetchedFoodItems = try context.fetch(foodItemFetch)
                
                let foodItem: Food_Items
                if let existingFood = fetchedFoodItems.first {
                    foodItem = existingFood
                } else {
                    foodItem = Food_Items(context: context)
                    foodItem.id = UUID()
                    foodItem.name = prod.strProductName
                    foodItem.price = prod.doubleProductPrice
                    foodItem.imageName = prod.strProductImage
                    foodItem.category = prod.objProductCategory.rawValue
                }
                
                order.addToProducts(foodItem)
            }
            
            user.addToOrders(order)
            
            try context.save()
            print("✅ Order saved for user: \(currentUserEmail)")
            
        } catch {
            print("❌ Failed to save order: \(error.localizedDescription)")
        }
    }
    
}
