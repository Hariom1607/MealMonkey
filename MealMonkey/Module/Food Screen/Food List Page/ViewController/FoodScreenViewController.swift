//
//  FoodScreenViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 10/08/25.
//

import UIKit

class FoodScreenViewController: UIViewController, FoodListTableViewCellDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!   // Loader for API data fetch
    @IBOutlet weak var lblCurrentLocation: UILabel!                  // Shows current selected location
    @IBOutlet weak var tblRecentItems: UITableView!                  // Table for showing recent items & products
    @IBOutlet weak var txtSearchFood: UITextField!                   // Search bar for filtering products
    @IBOutlet weak var btnCurrentLocation: UIButton!                 // Button for selecting current location
    
    // MARK: - Properties
    var selectedCategory: ProductCategory = .All                     // Currently selected category
    var arrProductData: [ProductModel] = []                          // Full product list from API
    var objProductCategory: ProductModel?                            // (unused, can be removed if not required)
    var recentItems: [ProductModel] = []                             // Recently viewed/ordered products
    
    var filteredProducts: [ProductModel] = []                        // Filtered product list (search/category based)
    var filteredCategories: [ProductCategory] = []                   // Filtered category list (search based)
    
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
        
        // Setup UI & delegates
        setupUI()
        setupTableView()
        setupSearchBar()
        
        // 👇 Initially hide table and other UI
        tblRecentItems.isHidden = true
        txtSearchFood.isHidden = true
        btnCurrentLocation.isHidden = true
        lblCurrentLocation.isHidden = true
        
        // Show loader
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        
        // Fetch products from API
        loadProducts()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initial setup
        setupUI()
        setupTableView()
        setupSearchBar()
        showLoader()       // 👈 show loader before loading products
        
        // Initialize with all categories
        filteredCategories = ProductCategory.allCases
        
        // Configure table view dynamic height
        tblRecentItems.rowHeight = UITableView.automaticDimension
        tblRecentItems.estimatedRowHeight = 200
        
        // Fetch products from API
        loadProducts()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        // Style search field
        styleViews([txtSearchFood], cornerRadius: 28, borderWidth: 0, borderColor: UIColor.black.cgColor)
        setTextFieldPadding([txtSearchFood])
        
        // Try name directly from UserDefaults first
        if let name = UserDefaults.standard.string(forKey: "currentUserName"), !name.isEmpty {
            setLeftAlignedTitle("Good Morning \(name)")
        } else {
            setLeftAlignedTitle("Good Morning")
        }
        
        // Add cart button in nav bar
        setCartButton(target: self, action: #selector(btnCartTapped))
    }
    
    // Show loader & fetch products
    private func showLoader() {
        ProductAPIHelper.shared.fetchProducts { [weak self] products in
            guard let self = self else { return }
            
            // Artificial delay for loader visibility
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
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
    
    // Hide loader and show content
    private func hideLoader() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        
        // 👇 Show other UI after loader hides
        tblRecentItems.isHidden = false
        txtSearchFood.isHidden = false
        btnCurrentLocation.isHidden = false
        lblCurrentLocation.isHidden = false
    }
    
    // Configure table view
    private func setupTableView() {
        tblRecentItems.register(UINib(nibName: "FoodListTableViewCell", bundle: nil),
                                forCellReuseIdentifier: "FoodListTableViewCell")
        tblRecentItems.rowHeight = UITableView.automaticDimension
        tblRecentItems.estimatedRowHeight = 200
    }
    
    // Add search bar text change listener
    private func setupSearchBar() {
        txtSearchFood.addTarget(self, action: #selector(searchTextChanged(_:)), for: .editingChanged)
    }
    
    // MARK: - API
    private func loadProducts() {
        ProductAPIHelper.shared.fetchProducts { [weak self] products in
            guard let self = self else { return }
            
            // Artificial delay for loader visibility
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.hideLoader()
                
                if let products = products {
                    self.arrProductData = products
                    self.filteredProducts = products
                    self.tblRecentItems.reloadData()
                } else {
                    print("❌ No products fetched from API")
                }
            }
        }
    }
    
    // MARK: - Actions
    // Search text change handler
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
    
    // Cart button tapped → navigate to cart screen
    @objc func btnCartTapped() {
        let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            self.navigationController?.pushViewController(menuVC, animated: true)
        }
    }
    
    // Current location button tapped
    @IBAction func btnCurrentLocationAction(_ sender: Any) {
        // TODO: Implement location picker
        print("📍 Current Location button tapped")
    }
    
    // MARK: - FoodListTableViewCellDelegate
    // Product tapped → show detail screen
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
    
    // Category tapped → reload table with selected category
    func foodListTableViewCell(_ cell: FoodListTableViewCell, didSelectCategory category: ProductCategory) {
        selectedCategory = category
        DispatchQueue.main.async {
            self.tblRecentItems.reloadData()
        }
    }
}
