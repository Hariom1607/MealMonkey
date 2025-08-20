//
//  FoodScreenViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 10/08/25.
//

import UIKit

class FoodScreenViewController: UIViewController, FoodListTableViewCellDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var lblCurrentLocation: UILabel!
    @IBOutlet weak var tblRecentItems: UITableView!
    @IBOutlet weak var txtSearchFood: UITextField!
    @IBOutlet weak var btnCurrentLocation: UIButton!
    
    // MARK: - Properties
    var selectedCategory: ProductCategory = .All
    var arrProductData: [ProductModel] = []           // Full product list
    var objProductCategory: ProductModel?             // (unused, maybe safe to remove if not needed)
    var recentItems: [ProductModel] = []              // Recently viewed/ordered products
    
    var filteredProducts: [ProductModel] = []         // Filtered based on search/category
    var filteredCategories: [ProductCategory] = []    // Filtered categories based on search
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // ✅ Always fetch the latest logged-in user from CoreData instead of stale UserDefaults
        if let email = UserDefaults.standard.string(forKey: "currentUserEmail"),
           let user = CoreDataHelper.shared.fetchUser(email: email),
           let name = user.name, !name.isEmpty {
            
            // Update navigation bar title with user's name
            setLeftAlignedTitle("Good Morning \(name)")
        } else {
            // Fallback if no user found or name is empty
            setLeftAlignedTitle("Good Morning")
        }
        
        // ✅ Refresh recent items list every time screen appears
        recentItems = RecentItemsHelper.shared.getRecentItems()
        tblRecentItems.reloadData()
        
        // ✅ Update current location label from UserDefaults
        if let address = UserDefaults.standard.string(forKey: "currentAddress"), !address.isEmpty {
            lblCurrentLocation.text = address
        } else {
            lblCurrentLocation.text = "Select your location"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTableView()
        setupSearchBar()
        showLoader()       // 👈 show loader before loading products
        
        // Initialize with all categories
        filteredCategories = ProductCategory.allCases
        
        tblRecentItems.rowHeight = UITableView.automaticDimension
        tblRecentItems.estimatedRowHeight = 200
        
        // Fetch products from API
        loadProducts()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        styleViews([txtSearchFood], cornerRadius: 28, borderWidth: 0, borderColor: UIColor.black.cgColor)
        setTextFieldPadding([txtSearchFood])
        
        // Try name directly from UserDefaults first
        if let name = UserDefaults.standard.string(forKey: "currentUserName"), !name.isEmpty {
            setLeftAlignedTitle("Good Morning \(name)")
        } else {
            setLeftAlignedTitle("Good Morning")
        }
        
        setCartButton(target: self, action: #selector(btnCartTapped))
    }
    
    private func showLoader() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        tblRecentItems.isHidden = true
    }

    private func hideLoader() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        tblRecentItems.isHidden = false
    }

    private func setupTableView() {
        tblRecentItems.register(UINib(nibName: "FoodListTableViewCell", bundle: nil),
                                forCellReuseIdentifier: "FoodListTableViewCell")
        tblRecentItems.rowHeight = UITableView.automaticDimension
        tblRecentItems.estimatedRowHeight = 200
    }
    
    private func setupSearchBar() {
        txtSearchFood.addTarget(self, action: #selector(searchTextChanged(_:)), for: .editingChanged)
    }
    
    // MARK: - API
    private func loadProducts() {
        ProductAPIHelper.shared.fetchProducts { [weak self] products in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.hideLoader()
                
                if let products = products {
                    self.arrProductData = products
                    self.filteredProducts = products
                    self.tblRecentItems.reloadData()
                } else {
                    print("❌ No products fetched from API")
                    // Optionally show alert/empty state UI here
                }
            }
        }
    }
    
    // MARK: - Actions
    @objc func searchTextChanged(_ textField: UITextField) {
        let searchText = textField.text?.lowercased() ?? ""
        
        if searchText.isEmpty {
            // Reset
            filteredProducts = arrProductData
            filteredCategories = ProductCategory.allCases
        } else {
            // Filter products
            filteredProducts = arrProductData.filter {
                $0.strProductName.lowercased().contains(searchText) ||
                $0.objProductCategory.rawValue.lowercased().contains(searchText)
            }
            
            // Filter categories
            filteredCategories = ProductCategory.allCases.filter {
                $0.rawValue.lowercased().contains(searchText)
            }
        }
        
        tblRecentItems.reloadData()
    }
    
    @objc func btnCartTapped() {
        let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            self.navigationController?.pushViewController(menuVC, animated: true)
        }
    }
    
    @IBAction func btnCurrentLocationAction(_ sender: Any) {
        // TODO: Implement location picker
        print("📍 Current Location button tapped")
    }
    
    // MARK: - FoodListTableViewCellDelegate
    func foodListTableViewCell(_ cell: FoodListTableViewCell, didSelectProduct product: ProductModel) {
        // Add to recent items
        RecentItemsHelper.shared.addProduct(product)
        
        // Navigate to detail screen
        let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "FoodDetailViewController") as? FoodDetailViewController {
            detailVC.product = product
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        
        // Refresh recent items
        recentItems = RecentItemsHelper.shared.getRecentItems()
        tblRecentItems.reloadData()
    }
    
    func foodListTableViewCell(_ cell: FoodListTableViewCell, didSelectCategory category: ProductCategory) {
        selectedCategory = category
        DispatchQueue.main.async {
            self.tblRecentItems.reloadData()
        }
    }
}
