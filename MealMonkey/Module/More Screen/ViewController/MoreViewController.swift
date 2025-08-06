//
//  MoreViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 04/08/25.
//

import UIKit

class MoreViewController: UIViewController {
    
    let arrTitles: [More] = More.items

    @IBOutlet weak var tblMore: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblMore.register(UINib(nibName: "MoreTableViewCell", bundle: nil), forCellReuseIdentifier: "MoreTableViewCell")
        
        setLeftAlignedTitle("More")
        setCartButton(target: self, action: #selector(cartButtonTapped))
    }

    @objc func cartButtonTapped() {
        
    }
}
