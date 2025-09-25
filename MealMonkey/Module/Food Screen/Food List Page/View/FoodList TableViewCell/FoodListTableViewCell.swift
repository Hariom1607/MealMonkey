//
//  FoodListTableViewCell.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 10/08/25.
//

import UIKit

// Delegate protocol to handle user interactions from this table view cell
protocol FoodListTableViewCellDelegate: AnyObject {
    func foodListTableViewCell(_ cell: FoodListTableViewCell, didSelectProduct product: ProductModel)
    func foodListTableViewCell(_ cell: FoodListTableViewCell, didSelectCategory category: ProductCategory)
}

// Custom table view cell that contains a collection view
class FoodListTableViewCell: UITableViewCell {
    
    weak var delegate: FoodListTableViewCellDelegate?
    
    // MARK: - Outlets
    @IBOutlet weak var collViewHeight: NSLayoutConstraint! // Dynamic height for collection view
    @IBOutlet weak var collViewFood: UICollectionView!     // Embedded collection view
    @IBOutlet weak var btnViewAll: UIButton!              // "View All" button
    @IBOutlet weak var lblCollViewHeading: UILabel!       // Heading label above collection
    
    // Defines different types of collection views this cell can represent
    enum CollectionType {
        case category
        case popular
        case mostPopular
        case RecentItems
    }
    
    // MARK: - Properties
    var selectedCategory: ProductCategory = .All
    var collectionType: CollectionType = .category
    
    // Categories list
    var categories: [ProductCategory] = [] {
        didSet {
            collViewFood.reloadData()
            DispatchQueue.main.async {
                self.collViewFood.layoutIfNeeded()
                self.updateCollectionHeight()
            }
        }
    }
    
    // Products list
    var products: [ProductModel] = [] {
        didSet {
            collViewFood.reloadData()
            DispatchQueue.main.async {
                self.collViewFood.layoutIfNeeded()
                self.updateCollectionHeight()
            }
        }
    }
    
    // Update collection view height dynamically (for vertical scrolling layouts)
    func updateCollectionHeight() {
        collViewFood.layoutIfNeeded()
        
        if let layout = collViewFood.collectionViewLayout as? UICollectionViewFlowLayout,
           layout.scrollDirection == .vertical {
            let height = collViewFood.collectionViewLayout.collectionViewContentSize.height
            self.collViewHeight.constant = height
        }
    }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collViewFood.dataSource = self
        collViewFood.delegate = self
        
        // Register all required collection view cells using struct constants
        collViewFood.register(
            UINib(nibName: Main.cells.homeFoodCategoryCell, bundle: nil),
            forCellWithReuseIdentifier: Main.cells.homeFoodCategoryCell
        )
        collViewFood.register(
            UINib(nibName: Main.cells.homePopulatFoodCell, bundle: nil),
            forCellWithReuseIdentifier: Main.cells.homePopulatFoodCell
        )
        collViewFood.register(
            UINib(nibName: Main.cells.homeMostPopulatFoodCell, bundle: nil),
            forCellWithReuseIdentifier: Main.cells.homeMostPopulatFoodCell
        )
        collViewFood.register(
            UINib(nibName: Main.cells.homeRecentItemsCell, bundle: nil),
            forCellWithReuseIdentifier: Main.cells.homeRecentItemsCell
        )
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // "View All" button action (currently empty, can be delegated if needed)
    @IBAction func btnViewAllClick(_ sender: Any) {
    }
    
    func applyTheme(_ theme: Theme) {
        lblCollViewHeading.textColor = theme.primaryFontColor
        btnViewAll.setTitleColor(theme.buttonColor, for: .normal)
        
        collViewFood.visibleCells.forEach { cell in
            if let cell = cell as? MostPopularCollectionViewCell {
                cell.applyTheme(theme)
            } else if let cell = cell as? PopularFoodCollectionViewCell {
                cell.applyTheme(theme)
            } else if let cell = cell as? RecentItemsCollectionViewCell {
                cell.applyTheme(theme)
            } else if let cell = cell as? FoodCategoryCollectionViewCell {
                // Add if needed
            }
        }
    }
}

// MARK: - Collection View Handling
extension FoodListTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // Number of items based on collection type
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionType {
        case .category:
            return categories.count
        default:
            return products.count
        }
    }
    
    // Configure and return the correct cell type
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionType {
        case .category:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Main.cells.homeFoodCategoryCell,
                for: indexPath
            ) as! FoodCategoryCollectionViewCell
            let category = categories[indexPath.row]
            cell.configure(with: category)
            return cell
            
        case .popular:
            let product = products[indexPath.row]
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Main.cells.homePopulatFoodCell,
                for: indexPath
            ) as! PopularFoodCollectionViewCell
            cell.configure(with: product)
            return cell
            
        case .mostPopular:
            let product = products[indexPath.row]
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Main.cells.homeMostPopulatFoodCell,
                for: indexPath
            ) as! MostPopularCollectionViewCell
            cell.configure(with: product)
            return cell
            
        case .RecentItems:
            let product = products[indexPath.row]
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Main.cells.homeRecentItemsCell,
                for: indexPath
            ) as! RecentItemsCollectionViewCell
            cell.configure(with: product)
            return cell
        }
    }
    
    // Set item sizes based on collection type
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionType == .category {
            return CGSize(width: 88, height: 113)
        } else if collectionType == .popular {
            return CGSize(width: collViewFood.frame.size.width, height: 242.19)
        } else if collectionType == .mostPopular {
            return CGSize(width: 228, height: 185)
        } else if collectionType == .RecentItems {
            return CGSize(width: collViewFood.frame.size.width, height: 79)
        } else {
            return CGSize(width: 100, height: 100)
        }
    }
    
    // Handle item selection
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionType {
        case .category:
            let selectedCategory = categories[indexPath.row]
            delegate?.foodListTableViewCell(self, didSelectCategory: selectedCategory)
        default:
            let selectedProduct = products[indexPath.row]
            delegate?.foodListTableViewCell(self, didSelectProduct: selectedProduct)
        }
    }
}
