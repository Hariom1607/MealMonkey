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
    var filteredProducts: [ProductModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtSearch.layer.cornerRadius = 28
        txtSearch.setPadding(left: 34, right: 34)
        txtSearch.addTarget(self, action: #selector(searchTextChanged(_:)), for: .editingChanged)
        
        // Title based on category
        let titleText: String
        switch selectedCategory {
        case .food: titleText = "Food"
        case .Beverages: titleText = "Beverages"
        case .Desserts: titleText = "Desserts"
        }
        setLeftAlignedTitleWithBack(titleText, target: self, action: #selector(dessertBackBtn))
        setCartButton(target: self, action: #selector(btnCartTapped))
        
        tblDesserts.register(UINib(nibName: "DessertsTableViewCell", bundle: nil),
                             forCellReuseIdentifier: "DessertsTableViewCell")
        
        // Fetch products from API
        ProductAPIHelper.shared.fetchProducts { [weak self] products in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let products = products {
                    // Filter products by selected type
                    self.arrProducts = products.filter { $0.objProductType == self.selectedCategory }
                    self.filteredProducts = self.arrProducts
                    self.tblDesserts.reloadData()
                } else {
                    print("❌ No products fetched from API")
                }
            }
        }
        
    }
    
    @objc func searchTextChanged(_ textField: UITextField) {
        let searchText = textField.text?.lowercased() ?? ""
        if searchText.isEmpty {
            filteredProducts = arrProducts
        } else {
            filteredProducts = arrProducts.filter {
                $0.strProductName.lowercased().contains(searchText)
            }
        }
        tblDesserts.reloadData()
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
