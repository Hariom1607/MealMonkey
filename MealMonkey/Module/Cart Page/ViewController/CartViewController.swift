//
//  CartViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 10/08/25.
//

import UIKit
import CoreData

/// Handles cart display and order placement
class CartViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var lblEmpty: UILabel!
    @IBOutlet weak var btnPlaceOrder: UIButton!
    @IBOutlet weak var tblCart: UITableView!
    
    /// Cart items for current user
    var cartItems: [CartItem] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Style button
        styleViews([btnPlaceOrder!], cornerRadius: 28, borderWidth: 0, borderColor: UIColor.black.cgColor)
        
        // Add title + back button
        setLeftAlignedTitleWithBack("Cart", target: self, action: #selector(backBtnTapped))
        
        // Register custom cell
        tblCart.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "CartTableViewCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Fetch cart items for logged-in user
        if let currentUserEmail = UserDefaults.standard.string(forKey: "currentUserEmail") {
            cartItems = CoreDataHelper.shared.fetchCart(for: currentUserEmail)
        }
        
        updateEmptyLabel()
        tblCart.reloadData()
    }
    
    // MARK: - Helpers
    
    /// Show/hide empty cart label & button
    func updateEmptyLabel() {
        lblEmpty.isHidden = !cartItems.isEmpty
        btnPlaceOrder.isHidden = cartItems.isEmpty
    }
    
    // MARK: - Actions
    
    /// Place order button tapped
    @IBAction func btnPlaceOrderAction(_ sender: Any) {
        guard let currentUserEmail = UserDefaults.standard.string(forKey: "currentUserEmail"),
              let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        // Refresh cart
        cartItems = CoreDataHelper.shared.fetchCart(for: currentUserEmail)
        
        // Check empty cart
        if cartItems.isEmpty {
            let alert = UIAlertController(title: "Cart is Empty",
                                          message: "Please add items to your cart before placing an order.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            // Fetch user
            guard let user = CoreDataHelper.shared.fetchUser(byEmail: currentUserEmail) else { return }
            
            // Create new order
            let order = Order(context: context)
            order.order_no = Int32((user.orders?.count ?? 0) + 1)
            order.total_price = cartItems.reduce(0.0) { $0 + ($1.price * Double($1.quantity)) }
            order.users = user
            
            // Add cart items as Food_Items
            for item in cartItems {
                let foodItem = Food_Items(context: context)
                foodItem.id = Int64(item.id)
                foodItem.name = item.name
                foodItem.price = item.price
                foodItem.imageName = item.image
                foodItem.category = item.category ?? ""
                foodItem.quantity = Int16(item.quantity)
                foodItem.productDescription = item.type ?? ""

                order.addToProducts(foodItem)
            }
            
            // Save order
            user.addToOrders(order)
            try context.save()
            print("✅ Order saved for user: \(currentUserEmail)")
            
            // Clear cart
            CoreDataHelper.shared.clearCart(for: currentUserEmail)
            cartItems.removeAll()
            updateEmptyLabel()
            tblCart.reloadData()
            
            // Success alert
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
    
    /// Handle back button tap
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
