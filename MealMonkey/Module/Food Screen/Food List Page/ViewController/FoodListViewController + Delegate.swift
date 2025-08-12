//
//  FoodListViewController + Delegate.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 10/08/25.
//

import Foundation
import UIKit

extension FoodScreenViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4 // one collection view per section
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodListTableViewCell", for: indexPath) as! FoodListTableViewCell
        cell.delegate = self
        
        if let layout = cell.collViewFood.collectionViewLayout as? UICollectionViewFlowLayout {
            if indexPath.row == 0 || indexPath.row == 2 {
                layout.scrollDirection = .horizontal
            } else {
                layout.scrollDirection = .vertical
            }
            cell.collViewFood.collectionViewLayout.invalidateLayout()
        }
        
        switch indexPath.row {
        case 0:
            cell.collectionType = .category
            cell.selectedCategory = selectedCategory
            cell.categories = ProductCategory.allCases
            cell.lblCollViewHeading.isHidden = true
            cell.btnViewAll.isHidden = true
            cell.collViewHeight.constant = 113 // fixed
            
        case 1:
            cell.collectionType = .popular
            cell.lblCollViewHeading.isHidden = false
            cell.btnViewAll.isHidden = false
            cell.lblCollViewHeading.text = "Popular"
            if selectedCategory == .All {
                cell.products = arrProductData.filter { $0.floatProductRating >= 4.0 && $0.floatProductRating < 4.5 }
            } else {
                cell.products = arrProductData.filter {
                    $0.floatProductRating >= 4.0 &&
                    $0.floatProductRating < 4.5 &&
                    $0.objProductCategory == selectedCategory
                }
            }
            cell.collViewHeight.constant = cell.collViewFood.collectionViewLayout.collectionViewContentSize.height
            
        case 2:
            cell.collectionType = .mostPopular
            cell.lblCollViewHeading.isHidden = false
            cell.btnViewAll.isHidden = false
            cell.lblCollViewHeading.text = "Most Popular"
            cell.collViewHeight.constant = 185
            if selectedCategory == .All {
                cell.products = arrProductData.filter { $0.floatProductRating >= 4.5 && $0.floatProductRating <= 5.0 }
            } else {
                cell.products = arrProductData.filter {
                    $0.floatProductRating >= 4.5 &&
                    $0.floatProductRating <= 5.0 &&
                    $0.objProductCategory == selectedCategory
                }
            }
            
        case 3:
            cell.collectionType = .RecentItems
            cell.lblCollViewHeading.isHidden = false
            cell.btnViewAll.isHidden = false
            cell.lblCollViewHeading.text = "Recent Items"
            cell.products = recentItems
            cell.collViewHeight.constant = cell.collViewFood.collectionViewLayout.collectionViewContentSize.height
            
        default:
            break
        }
        
        cell.collViewFood.reloadData()
        DispatchQueue.main.async {
            cell.collViewFood.layoutIfNeeded()
            cell.updateCollectionHeight()
        }
        return cell
    }
}
