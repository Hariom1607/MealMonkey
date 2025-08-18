//
//  OrderListViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 12/08/25.
//

import UIKit

class OrderListViewController: UIViewController {
    
    @IBOutlet weak var lblEmpty: UILabel!
    @IBOutlet weak var tblOrderList: UITableView!
    
    var orders: [[ProductModel]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        orders = loadOrdersFromUserDefaults()
        
        setLeftAlignedTitleWithBack("Order List", target: self, action: #selector(backBtnTapped))
        tblOrderList.register(UINib(nibName: "OrderListTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderListTableViewCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        orders = loadOrdersFromUserDefaults()
        
        let coreDataOrders = fetchOrdersForCurrentUser()
        
        self.orders = coreDataOrders.map { order in
            let foodItems = (order.products?.allObjects as? [Food_Items])?.sorted(by: { $0.name ?? "" < $1.name ?? "" }) ?? []
            
            return foodItems.map { foodItem in
                ProductModel(
                    intId: 0,
                    strProductName: foodItem.name ?? "",
                    strProductDescription: foodItem.productDescription ?? "",
                    floatProductRating: 0.0,
                    doubleProductPrice: foodItem.price,
                    strProductImage: foodItem.imageName ?? "",
                    intProductQty: Int(foodItem.quantity),
                    intTotalNumberOfRatings: 0,
                    objProductCategory: ProductCategory(rawValue: foodItem.category ?? "") ?? .Gujarati,
                    objProductType: ProductType.food
                )
            }
        }
        
        updateEmptyLabel()
        tblOrderList.reloadData()
    }
    
    func updateEmptyLabel() {
        let isEmpty = orders.isEmpty
        lblEmpty.isHidden = !isEmpty
        tblOrderList.isHidden = isEmpty
    }
    
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
