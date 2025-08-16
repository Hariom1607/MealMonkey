//
//  CartViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 10/08/25.
//

import UIKit

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
        
        if !appDelegate.arrCart.isEmpty {
            // Save the current cart as a new order
            appDelegate.arrOrders.append(appDelegate.arrCart)
            
            // Save orders using helper function from helpers file
            saveOrdersToUserDefaults(appDelegate.arrOrders)
            
            // Clear cart
            appDelegate.arrCart.removeAll()
            saveCartToUserDefaults(cartArray: [])
            
            // Show success alert
            let alert = UIAlertController(title: "Order Placed",
                                          message: "Your order has been placed successfully!",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.tblCart.reloadData()
            }))
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Cart is Empty",
                                          message: "Please add items to your cart before placing an order.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
        updateEmptyLabel()
    }
    
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
