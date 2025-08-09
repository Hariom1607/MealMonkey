//
//  NewPasswordViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 04/08/25.
//

import UIKit

class NewPasswordViewController: UIViewController {

    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let allViews = [txtNewPassword!, txtConfirmPassword!, btnSubmit!]
        styleViews(allViews, cornerRadius: 28, borderWidth: 0, borderColor: UIColor.black.cgColor)
        
        txtNewPassword.setPadding(left: 34)
        txtConfirmPassword.setPadding(left: 34)
        
        setLeftAlignedTitleWithBack("New Password", target: self, action: #selector(backButtonTapped))

    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSubmit(_ sender: Any) {
        let storyboard = UIStoryboard(name: "FeatureStoryboard", bundle: nil)
        if let mlvc = storyboard.instantiateViewController(identifier: "FeatureViewController") as? FeatureViewController{
            self.navigationController?.pushViewController(mlvc, animated: true)
        }
    }
    
}
