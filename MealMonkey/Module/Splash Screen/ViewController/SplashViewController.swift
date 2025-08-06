//
//  SplashViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 31/07/25.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
//        self.navigationController?.navigationBar.isHidden = true
        sleep(3)

        
        let storyboard = UIStoryboard(name: "UserLoginStoryboard", bundle: nil)
        if let mlvc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController{
            self.navigationController?.pushViewController(mlvc, animated: true)
            
        }
    }
}
