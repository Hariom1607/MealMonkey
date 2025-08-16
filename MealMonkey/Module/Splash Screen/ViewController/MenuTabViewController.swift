//
//  MenuTabViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 04/08/25.
//

import UIKit

class MenuTabViewController: UITabBarController {

    @IBOutlet weak var customTabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true

        // Do any additional setup after loading the view.
    }

}
