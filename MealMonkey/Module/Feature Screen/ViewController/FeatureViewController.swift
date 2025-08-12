//
//  FeatureViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 04/08/25.
//

import UIKit

class FeatureViewController: UIViewController {
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var colView: UICollectionView!
    
    let features: [Feature] = Feature.features
    var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        btnNext.layer.cornerRadius = 28
        pageControl.numberOfPages = features.count
        updateLabels(for: 0)
        btnNext.setTitle("Next", for: .normal)
        
        colView.register(UINib(nibName: "FeatureCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FeatureCollectionViewCell")
    }
    
    func updateLabels(for index: Int) {
        let model = features[index]
        lblTitle.text = model.title
        lblSubTitle.text = model.subTitle
        pageControl.currentPage = index
        currentIndex = index
        btnNext.setTitle(index == features.count - 1 ? "Done" : "Next", for: .normal)
    }
    
    
    @IBAction func btnSubmitAction(_ sender: Any) {
        
        let currentPage = pageControl.currentPage
        
        if currentPage < features.count - 1 {
            // Scroll to next page
            let nextPage = currentPage + 1
            let xOffset = CGFloat(nextPage) * colView.frame.width
            colView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: true)
            pageControl.currentPage = nextPage
            updateLabels(for: nextPage)
        }
        
        else {
            let storyboard = UIStoryboard(name: "TabBarStoryboard", bundle: nil)
            if let menuVC = storyboard.instantiateViewController(withIdentifier: "MenuTabViewController") as? MenuTabViewController{
                self.navigationController?.pushViewController(menuVC, animated: true)
            }
        }
    }
}
