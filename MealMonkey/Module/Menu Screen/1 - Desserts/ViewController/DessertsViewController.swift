//
//  DessertsViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 06/08/25.
//

import UIKit

class DessertsViewController: UIViewController {

    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tblDesserts: UITableView!
    
    var arrProducts: [Product] = Product.allProducts()
    var selectedProduct: Menu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtSearch.layer.cornerRadius = 28
        txtSearch.setPadding(left: 34)
        
        setLeftAlignedTitleWithBack("Desserts", target: self, action: #selector(dessertBackBtn))
        setCartButton(target: self, action: #selector(btnCartTapped))
        
        tblDesserts.register(UINib(nibName: "DessertsTableViewCell", bundle: nil), forCellReuseIdentifier: "DessertsTableViewCell")

    }
    
    @objc func dessertBackBtn(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnCartTapped() {
        
    }
}
