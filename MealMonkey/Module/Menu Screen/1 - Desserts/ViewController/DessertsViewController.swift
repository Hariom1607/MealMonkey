//
//  DessertsViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 06/08/25.
//

import UIKit

class DessertsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tblDesserts: UITableView!
    
    // MARK: - Properties
    var selectedCategory: ProductType = .food
    var arrProducts: [ProductModel] = []          // All fetched products for the selected category
    var selectedProduct: Menu?                   // (Possibly unused – check if needed later)
    var filteredProducts: [ProductModel] = []    // Search results
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        fetchProducts()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        // Search box styling
        txtSearch.layer.cornerRadius = 28
        txtSearch.setPadding(left: 34, right: 34)
        txtSearch.addTarget(self, action: #selector(searchTextChanged(_:)), for: .editingChanged)
        
        // Set navigation title dynamically based on category
        let titleText: String
        switch selectedCategory {
        case .food: titleText = "Food"
        case .Beverages: titleText = "Beverages"
        case .Desserts: titleText = "Desserts"
        }
        setLeftAlignedTitleWithBack(titleText, target: self, action: #selector(dessertBackBtn))
        setCartButton(target: self, action: #selector(btnCartTapped))
        
        // Register custom table view cell
        tblDesserts.register(UINib(nibName: "DessertsTableViewCell", bundle: nil),
                             forCellReuseIdentifier: "DessertsTableViewCell")
    }
    
    // MARK: - API Call
    private func fetchProducts() {
        ProductAPIHelper.shared.fetchProducts { [weak self] products in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let products = products {
                    // ✅ Filter products by selected category
                    self.arrProducts = products.filter { $0.objProductType == self.selectedCategory }
                    self.filteredProducts = self.arrProducts
                    self.tblDesserts.reloadData()
                } else {
                    print("❌ No products fetched from API")
                }
            }
        }
    }
    
    // MARK: - Actions
    @objc func searchTextChanged(_ textField: UITextField) {
        let searchText = textField.text?.lowercased() ?? ""
        filteredProducts = searchText.isEmpty
        ? arrProducts
        : arrProducts.filter { $0.strProductName.lowercased().contains(searchText) }
        
        tblDesserts.reloadData()
    }
    
    @objc func dessertBackBtn() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnCartTapped() {
        let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
        if let cartVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            self.navigationController?.pushViewController(cartVC, animated: true)
        }
    }
}
