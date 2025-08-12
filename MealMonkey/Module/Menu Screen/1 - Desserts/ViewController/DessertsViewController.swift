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
    
    var selectedCategory: ProductType = .food
    var arrProducts: [ProductModel] = []
    var selectedProduct: Menu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtSearch.layer.cornerRadius = 28
        txtSearch.setPadding(left: 34, right: 34)
        
        let titleText: String
        switch selectedCategory {
        case .food:
            titleText = "Food"
        case .Beverages:
            titleText = "Beverages"
        case .Desserts:
            titleText = "Desserts"
        }
        
        setLeftAlignedTitleWithBack(titleText, target: self, action: #selector(dessertBackBtn))
        setCartButton(target: self, action: #selector(btnCartTapped))
        
        tblDesserts.register(UINib(nibName: "DessertsTableViewCell", bundle: nil), forCellReuseIdentifier: "DessertsTableViewCell")
        
        arrProducts = ProductModel.addProductData().filter { $0.objProductType == selectedCategory }
        
    }
    
    @objc func dessertBackBtn(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnCartTapped() {
        let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController{
            self.navigationController?.pushViewController(menuVC, animated: true)
        }
    }
}
