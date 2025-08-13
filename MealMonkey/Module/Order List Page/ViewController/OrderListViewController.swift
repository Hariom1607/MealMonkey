//
//  OrderListViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 12/08/25.
//

import UIKit

class OrderListViewController: UIViewController {
    
    @IBOutlet weak var tblOrderList: UITableView!
    
    var orders: [[ProductModel]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        orders = loadOrdersFromUserDefaults()
        
        setLeftAlignedTitleWithBack("Order List", target: self, action: #selector(backBtnTapped))
        tblOrderList.register(UINib(nibName: "OrderListTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderListTableViewCell")
        
    }
    
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
