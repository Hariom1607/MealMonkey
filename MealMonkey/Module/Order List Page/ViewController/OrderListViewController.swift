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
        orders = loadOrdersFromUserDefaults() 
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
