//
//  Feature Controller + delegate.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 04/08/25.
//

import Foundation
import UIKit

// MARK: - CollectionView Delegate & DataSource
extension FeatureViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    /// Number of feature items to show in collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return features.count
    }
    
    /// Configure and return feature cell for given index
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Main.cells.featureCell, for: indexPath) as! FeatureCollectionViewCell
        let model = features[indexPath.item]
        cell.configure(with: model) // Pass data model to cell
        return cell
    }
    
    /// Set size of each collection view cell (fills width of screen, fixed height)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSizeMake(collectionView.frame.size.width, 313.26)
    }
}

// MARK: - ScrollView Delegate (for updating labels while swiping)
extension FeatureViewController: UIScrollViewDelegate {
    
    /// Called when user finishes manual swipe (deceleration stops)
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        updateLabels(for: pageNumber) // Update title, subtitle, button, and page control
    }
    
    /// Called when programmatic scrolling ends (e.g., tapping "Next")
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.frame.width)
        updateLabels(for: index) // Sync labels and button with current page
    }
}
