//
//  FoodListTableViewCell.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 10/08/25.
//

import UIKit

protocol FoodListTableViewCellDelegate: AnyObject {
    func foodListTableViewCell(_ cell: FoodListTableViewCell, didSelectProduct product: ProductModel)
    func foodListTableViewCell(_ cell: FoodListTableViewCell, didSelectCategory category: ProductCategory)
}

class FoodListTableViewCell: UITableViewCell {
    
    weak var delegate: FoodListTableViewCellDelegate?
    
    @IBOutlet weak var collViewHeight: NSLayoutConstraint!
    @IBOutlet weak var collViewFood: UICollectionView!
    @IBOutlet weak var btnViewAll: UIButton!
    @IBOutlet weak var lblCollViewHeading: UILabel!
    
    enum CollectionType {
        case category
        case popular
        case mostPopular
        case RecentItems
    }
    
    var selectedCategory: ProductCategory = .All
    var collectionType: CollectionType = .category
    var categories: [ProductCategory] = [] {
        didSet {
            collViewFood.reloadData()
            DispatchQueue.main.async {
                self.collViewFood.layoutIfNeeded()
                self.updateCollectionHeight()
            }
        }
    }
    
    var products: [ProductModel] = [] {
        didSet {
            collViewFood.reloadData()
            DispatchQueue.main.async {
                self.collViewFood.layoutIfNeeded()
                self.updateCollectionHeight()
            }
        }
    }
    
    func updateCollectionHeight() {
        if let layout = collViewFood.collectionViewLayout as? UICollectionViewFlowLayout,
           layout.scrollDirection == .vertical {
            self.collViewHeight.constant = self.collViewFood.collectionViewLayout.collectionViewContentSize.height
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collViewFood.dataSource = self
        collViewFood.delegate = self
        
        collViewFood.register(UINib(nibName: "FoodCategoryCollectionViewCell", bundle: nil),
                              forCellWithReuseIdentifier: "FoodCategoryCollectionViewCell")
        collViewFood.register(UINib(nibName: "PopularFoodCollectionViewCell", bundle: nil),
                              forCellWithReuseIdentifier: "PopularFoodCollectionViewCell")
        collViewFood.register(UINib(nibName: "MostPopularCollectionViewCell", bundle: nil),
                              forCellWithReuseIdentifier: "MostPopularCollectionViewCell")
        collViewFood.register(UINib(nibName: "RecentItemsCollectionViewCell", bundle: nil),
                              forCellWithReuseIdentifier: "RecentItemsCollectionViewCell")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnViewAllClick(_ sender: Any) {
    }
}

extension FoodListTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionType {
        case .category:
            return categories.count
        default:
            return products.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        switch collectionType {
        case .category:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCategoryCollectionViewCell", for: indexPath) as! FoodCategoryCollectionViewCell
            let category = categories[indexPath.row]
            cell.configure(with: category)
            return cell
            
        case .popular:
            let product = products[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularFoodCollectionViewCell", for: indexPath) as! PopularFoodCollectionViewCell
            cell.configure(with: product)
            return cell
            
        case .mostPopular:
            let product = products[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MostPopularCollectionViewCell", for: indexPath) as! MostPopularCollectionViewCell
            cell.configure(with: product)
            return cell
            
        case .RecentItems:
            let product = products[indexPath.row]
            let cell: RecentItemsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentItemsCollectionViewCell", for: indexPath) as! RecentItemsCollectionViewCell
            cell.configure(with: product)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionType == .category {
            return CGSize(width: 88, height: 113)
        } else if collectionType == .popular {
            return CGSize(width: collViewFood.frame.size.width, height: 242.19)
        } else if collectionType == .mostPopular {
            return CGSize(width: 228, height: 185)
        } else if collectionType == .RecentItems {
            return CGSize(width: collViewFood.frame.size.width, height: 79)
        } else{
            return CGSize(width: 100, height: 100)
        }
    }
    
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
