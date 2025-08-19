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
    
    var cartItems: [CartItem] = []
    
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
        
        if let currentUserEmail = UserDefaults.standard.string(forKey: "currentUserEmail") {
            cartItems = CoreDataHelper.shared.fetchCart(for: currentUserEmail)
        }
        updateEmptyLabel()
        tblCart.reloadData()
    }
    
    
    func updateEmptyLabel() {
        lblEmpty.isHidden = !cartItems.isEmpty
        btnPlaceOrder.isHidden = cartItems.isEmpty
    }
    
    @IBAction func btnPlaceOrderAction(_ sender: Any) {
        
        guard let currentUserEmail = UserDefaults.standard.string(forKey: "currentUserEmail"),
              let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        cartItems = CoreDataHelper.shared.fetchCart(for: currentUserEmail)
        
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
            
            // Add products to order
            for item in cartItems {
                let foodItem = Food_Items(context: context)
                foodItem.id = Int64(item.id)
                foodItem.name = item.name
                foodItem.price = item.price
                foodItem.imageName = item.image
                foodItem.category = "" // you can map category if available
                foodItem.quantity = Int16(item.quantity)
                foodItem.productDescription = "" // map description if available
                
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
    
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
