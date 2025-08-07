//
//  ForgotPasswordViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 01/08/25.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false

        let allViews = [txtEmail!, btnSend!]
        styleViews(allViews, cornerRadius: 28, borderWidth: 0, borderColor: UIColor.black.cgColor)
        txtEmail.setPadding(left: 34, right: 34)
        
        setLeftAlignedTitleWithBack("Forgot Password", target: self, action: #selector(backButtonTapped))
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func btnSendAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "UserLoginStoryboard", bundle: nil)
        if let mlvc = storyboard.instantiateViewController(identifier: "OtpViewController") as? OtpViewController {
            self.navigationController?.pushViewController(mlvc, animated: true)
        }
    }
}
