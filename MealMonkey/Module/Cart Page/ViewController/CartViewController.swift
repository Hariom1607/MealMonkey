//
//  CartViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 10/08/25.
//

import UIKit
import CoreData

class CartViewController: UIViewController {
    
    @IBOutlet weak var lblEmpty: UILabel!
    @IBOutlet weak var btnPlaceOrder: UIButton!
    @IBOutlet weak var tblCart: UITableView!
    
    var cartItems: [ProductModel] {
        return (UIApplication.shared.delegate as? AppDelegate)?.arrCart ?? []
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleViews([btnPlaceOrder!], cornerRadius: 28, borderWidth: 0, borderColor: UIColor.black.cgColor)
        
        setLeftAlignedTitleWithBack("Cart", target: self, action: #selector(backBtnTapped))
        
        tblCart.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "CartTableViewCell")
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            // Load saved cart
            let savedCartArray = loadCartFromUserDefaults()
            appDelegate.arrCart = savedCartArray.map { dictToProduct($0) }
            
            // Load saved orders (THIS WAS MISSING)
            let savedOrders = loadOrdersFromUserDefaults()
            appDelegate.arrOrders = savedOrders
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let savedCartArray = loadCartFromUserDefaults()
            appDelegate.arrCart = savedCartArray.map { dictToProduct($0) }
        }
        
        updateEmptyLabel()
        tblCart.reloadData()
    }
    
    func updateEmptyLabel() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let isCartEmpty = appDelegate.arrCart.isEmpty
            lblEmpty.isHidden = !isCartEmpty
            btnPlaceOrder.isHidden = isCartEmpty
        }
    }
    
    @IBAction func btnPlaceOrderAction(_ sender: Any) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let cart = appDelegate.arrCart
        if cart.isEmpty {
            let alert = UIAlertController(title: "Cart is Empty",
                                          message: "Please add items to your cart before placing an order.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        // 1️⃣ Fetch current user from Core Data
        guard let currentUserEmail = UserDefaults.standard.string(forKey: "currentUser") else { return }
        
        let userRequest: NSFetchRequest<User> = User.fetchRequest()
        userRequest.predicate = NSPredicate(format: "email == %@", currentUserEmail)
        
        do {
            let users = try context.fetch(userRequest)
            let user: User
            
            if let existingUser = users.first {
                user = existingUser
            } else {
                // Create new user if not exist
                user = User(context: context)
                user.id = UUID()
                user.email = currentUserEmail
                user.name = UserDefaults.standard.string(forKey: "userName")
            }
            
            // 2️⃣ Create new order
            let order = Order(context: context)
            order.order_no = Int32((user.orders?.count ?? 0) + 1)
            order.total_price = cart.reduce(0.0) { $0 + ($1.doubleProductPrice * Double($1.intProductQty ?? 1)) }
            order.users = user
            
            // 3️⃣ Add products to order
            for prod in cart {
                let foodItem = Food_Items(context: context)
                foodItem.id = UUID()
                foodItem.name = prod.strProductName
                foodItem.price = prod.doubleProductPrice
                foodItem.imageName = prod.strProductImage
                foodItem.category = prod.objProductCategory.rawValue
                foodItem.quantity = Int16(prod.intProductQty ?? 1)
                foodItem.productDescription = prod.strProductDescription

                order.addToProducts(foodItem)
            }
            
            // 4️⃣ Add order to user and save context
            user.addToOrders(order)
            try context.save()
            print("✅ Order saved for user: \(currentUserEmail)")
            
            // 5️⃣ Save to UserDefaults / arrOrders
            appDelegate.arrOrders.append(cart)
            saveOrdersToUserDefaults(appDelegate.arrOrders)
            
            // 6️⃣ Clear cart
            appDelegate.arrCart.removeAll()
            saveCartToUserDefaults(cartArray: [])
            updateEmptyLabel()
            tblCart.reloadData()
            
            // 7️⃣ Show success alert
            let alert = UIAlertController(title: "Order Placed",
                                          message: "Your order has been placed successfully!",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            
        } catch {
            print("❌ Failed to save order: \(error.localizedDescription)")
            let alert = UIAlertController(title: "Error",
                                          message: "Failed to place order. Please try again.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
        
    }
    
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
