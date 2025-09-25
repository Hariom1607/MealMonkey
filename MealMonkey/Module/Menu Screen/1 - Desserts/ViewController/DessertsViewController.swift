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
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applyTheme),
            name: Notification.Name("themeChanged"),
            object: nil
        )
        applyTheme()
        setupUI()
        fetchProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.updateCartBadge()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        txtSearch.layer.cornerRadius = 28
        txtSearch.setPadding(left: 34, right: 34)
        txtSearch.addTarget(self, action: #selector(searchTextChanged(_:)), for: .editingChanged)
        
        // Search placeholder for the selected category
        switch selectedCategory {
        case .food: txtSearch.placeholder = Main.MenuLabels.searchFoodPlaceholder
        case .Beverages: txtSearch.placeholder = Main.MenuLabels.searchBeveragesPlaceholder
        case .Desserts: txtSearch.placeholder = Main.MenuLabels.searchDessertsPlaceholder
        }
        
        let titleText: String
        switch selectedCategory {
        case .food: titleText = Main.MenuLabels.categoryFood
        case .Beverages: titleText = Main.MenuLabels.categoryBeverages
        case .Desserts: titleText = Main.MenuLabels.categoryDesserts
        }
        
        setLeftAlignedTitleWithBack(titleText, target: self, action: #selector(dessertBackBtn))
        setCartButton(target: self, action: #selector(btnCartTapped))
        
        tblDesserts.register(UINib(nibName: Main.cells.menuDessertCell, bundle: nil),
                             forCellReuseIdentifier: Main.cells.menuDessertCell)
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
        let storyboard = UIStoryboard(name: Main.storyboards.menu, bundle: nil)
        if let cartVC = storyboard.instantiateViewController(withIdentifier: Main.viewController.cart) as? CartViewController {
            self.navigationController?.pushViewController(cartVC, animated: true)
        }
    }
    @objc func applyTheme() {
        let theme = ThemeManager.currentTheme
        
        // View background
        view.backgroundColor = theme.backgroundColor
        
        // Search bar styling
        txtSearch.backgroundColor = theme.cellBackgroundColor
        txtSearch.textColor = theme.primaryFontColor
        txtSearch.layer.cornerRadius = 28
        txtSearch.layer.borderWidth = 1
        txtSearch.clipsToBounds = true
        if let placeholder = txtSearch.placeholder {
            txtSearch.attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [NSAttributedString.Key.foregroundColor: theme.placeholderColor]
            )
        }
        
        // Table view background
        tblDesserts.backgroundColor = theme.backgroundColor
        tblDesserts.reloadData() // So all cells get themed
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("themeChanged"), object: nil)
    }
}
