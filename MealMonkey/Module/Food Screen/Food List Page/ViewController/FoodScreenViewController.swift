//
//  FoodScreenViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 10/08/25.
//

import UIKit

class FoodScreenViewController: UIViewController, FoodListTableViewCellDelegate {
    
    @IBOutlet weak var tblRecentItems: UITableView!
    @IBOutlet weak var txtSearchFood: UITextField!
    @IBOutlet weak var btnCurrentLocation: UIButton!
    
    var selectedCategory: ProductCategory = .All
    var arrProductData: [ProductModel] = ProductModel.addProductData()
    var objProductCategory: ProductModel?
    var recentItems: [ProductModel] = []
    
    var filteredProducts: [ProductModel] = []
    var filteredCategories: [ProductCategory] = []
    
    override func viewWillAppear(_ animated: Bool) {
        recentItems = RecentItemsHelper.shared.getRecentItems()
        tblRecentItems.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredProducts = arrProductData
        filteredCategories = ProductCategory.allCases
        
        styleViews([txtSearchFood], cornerRadius: 28, borderWidth: 0, borderColor: UIColor.black.cgColor)
        setTextFieldPadding([txtSearchFood])
        
        txtSearchFood.addTarget(self, action: #selector(searchTextChanged(_:)), for: .editingChanged)
        
        setLeftAlignedTitle("Good morning Hariom!")
        setCartButton(target: self, action: #selector(btnCartTapped))
        
        tblRecentItems.register(UINib(nibName: "FoodListTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodListTableViewCell")
        
        DispatchQueue.main.async {
            self.tblRecentItems.reloadData()
        }
    }
    
    @objc func searchTextChanged(_ textField: UITextField) {
        let searchText = textField.text?.lowercased() ?? ""
        
        if searchText.isEmpty {
            // Reset to all data
            filteredProducts = arrProductData
            filteredCategories = ProductCategory.allCases
        } else {
            // Filter products by name or type
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
        if let menuVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController{
            self.navigationController?.pushViewController(menuVC, animated: true)
        }
    }
    
    @IBAction func btnCurrentLocationAction(_ sender: Any) {
    }
    
    func foodListTableViewCell(_ cell: FoodListTableViewCell, didSelectProduct product: ProductModel) {
        RecentItemsHelper.shared.addProduct(product)
        
        let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "FoodDetailViewController") as? FoodDetailViewController {
            detailVC.product = product
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        
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
