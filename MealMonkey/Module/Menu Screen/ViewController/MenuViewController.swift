//
//  MenuViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 04/08/25.
//

import UIKit

/// Displays the list of menu categories (Food, Beverages, Desserts)
class MenuViewController: UIViewController {
    
    /// Search bar for filtering menu items
    @IBOutlet weak var txtSearch: UITextField!
    
    @IBOutlet weak var imgSideBar: UIImageView!
    /// Table view that shows menu categories
    @IBOutlet weak var tblMenu: UITableView!
    
    /// Data source for the table (Food, Beverages, Desserts)
    var menuItems: [Menu] = []
    var filteredMenuItems: [Menu] = []   // For search
    
    override func viewWillAppear(_ animated: Bool) {
        self.updateCartBadge()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyTheme()
        
        // Listen for theme changes
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applyTheme),
            name: Notification.Name("themeChanged"),
            object: nil
        )
        
        txtSearch.placeholder = Main.MenuLabels.searchPlaceholder
        txtSearch.setPadding(left: 34, right: 34)
        
        // ✅ Show navigation bar for this screen
        self.navigationController?.isNavigationBarHidden = false
        
        // ✅ Set title ("Menu") and add cart button to nav bar
        setLeftAlignedTitle(Main.BackBtnTitle.menu)
        setCartButton(target: self, action: #selector(cartBtnTapped))
        
        // ✅ Style search field with padding and rounded corners
        txtSearch.setPadding(left: 34, right: 34)
        let allviews = [txtSearch!]
        styleViews(allviews, cornerRadius: 28, borderWidth: 1, borderColor: UIColor.black.cgColor)
        
        // ✅ Register custom table view cell
        tblMenu.register(UINib(nibName: Main.cells.menuCell, bundle: nil),
                         forCellReuseIdentifier: Main.cells.menuCell)
        
        // ✅ Load static menu data
        txtSearch.addTarget(self, action: #selector(searchTextChanged(_:)), for: .editingChanged)
        menuItems = Menu.populateMenu()
        filteredMenuItems = menuItems
        updateEmptyState()
    }
    
    /// Opens CartViewController when cart button is tapped
    @objc func cartBtnTapped() {
        let storyboard = UIStoryboard(name: Main.storyboards.menu, bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: Main.viewController.cart) as? CartViewController {
            self.navigationController?.pushViewController(menuVC, animated: true)
        }
    }
    
    // ✅ Search Filtering
    @objc func searchTextChanged(_ textField: UITextField) {
        let searchText = textField.text?.lowercased() ?? ""
        
        if searchText.isEmpty {
            filteredMenuItems = menuItems
        } else {
            filteredMenuItems = menuItems.filter { menu in
                return menu.strName.lowercased().contains(searchText)
            }
        }
        
        tblMenu.reloadData()
        updateEmptyState()
    }
    
    @objc func applyTheme() {
        let theme = ThemeManager.currentTheme
        
        // View background
//        view.backgroundColor = theme.backgroundColor
        
        // Search bar styling
        txtSearch.backgroundColor = theme.cellBackgroundColor
        txtSearch.textColor = theme.primaryFontColor
        txtSearch.layer.cornerRadius = 28
        txtSearch.layer.borderWidth = 1
        txtSearch.clipsToBounds = true
        txtSearch.layer.borderColor = UIColor.black.cgColor
        if let placeholder = txtSearch.placeholder {
            txtSearch.attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [NSAttributedString.Key.foregroundColor: theme.placeholderColor]
            )
        }
        
        // TableView background
        tblMenu.backgroundColor = .clear
        tblMenu.reloadData() // so cells also get themed
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("themeChanged"), object: nil)
    }
}
