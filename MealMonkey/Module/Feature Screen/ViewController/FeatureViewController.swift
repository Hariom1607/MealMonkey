//
//  FeatureViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 04/08/25.
//

import UIKit

// Controller for the onboarding feature screens
class FeatureViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var btnNext: UIButton!          // Button to go to next feature / finish onboarding
    @IBOutlet weak var pageControl: UIPageControl! // Page indicator
    @IBOutlet weak var lblTitle: UILabel!          // Title of current feature
    @IBOutlet weak var lblSubTitle: UILabel!       // Subtitle/description of current feature
    @IBOutlet weak var colView: UICollectionView!  // Collection view for feature images
    
    // MARK: - Properties
    let features: [Feature] = Feature.features  // Data source (static features array)
    var currentIndex: Int = 0                   // Tracks current page index
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set button title for current index
        btnNext.setTitle(currentIndex == 2 ? Localized("label_done") : Localized("label_next"), for: .normal)
        
        // Update first page labels
        updateLabels(for: currentIndex)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide navigation bar for onboarding screens
        self.navigationController?.navigationBar.isHidden = true
        
        // Button styling
        btnNext.layer.cornerRadius = 28
        btnNext.setTitle(Main.FeatureTexts.next, for: .normal)
        
        // Setup page control
        pageControl.numberOfPages = features.count
        
        // Initialize with first feature
        updateLabels(for: 0)
        btnNext.setTitle(Main.Labels.next, for: .normal)
        
        // Register custom collection view cell
        colView.register(UINib(nibName: Main.cells.featureCell, bundle: nil), forCellWithReuseIdentifier: Main.cells.featureCell)
    }
    
    // MARK: - Helpers
    /// Updates labels and page control for given feature index
    func updateLabels(for index: Int) {
        switch index {
        case 0:
            lblTitle.text = Localized("feature_find_food_title")
            lblSubTitle.text = Localized("feature_find_food_subtitle")
        case 1:
            lblTitle.text = Localized("feature_fast_delivery_title")
            lblSubTitle.text = Localized("feature_fast_delivery_subtitle")
        case 2:
            lblTitle.text = Localized("feature_live_tracking_title")
            lblSubTitle.text = Localized("feature_live_tracking_subtitle")
        default:
            break
        }

        pageControl.currentPage = index
        currentIndex = index

        // Localize button
        btnNext.setTitle(index == 2 ? Localized("label_done") : Localized("label_next"), for: .normal)
    }
    
    // MARK: - Actions
    @IBAction func btnSubmitAction(_ sender: Any) {
        let currentPage = pageControl.currentPage
        
        if currentPage < features.count - 1 {
            // Scroll to next feature page
            let nextPage = currentPage + 1
            let xOffset = CGFloat(nextPage) * colView.frame.width
            colView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: true)
            pageControl.currentPage = nextPage
            updateLabels(for: nextPage)
        }
        else {
            // Navigate to Menu screen after last feature
            let storyboard = UIStoryboard(name: Main.storyboards.userlogin, bundle: nil)
            if let menuVC = storyboard.instantiateViewController(withIdentifier: Main.viewController.login) as? LoginViewController {
                self.navigationController?.pushViewController(menuVC, animated: true)
            }
        }
    }
}
