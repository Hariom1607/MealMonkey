//
//  OtpViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 07/08/25.
//

import UIKit

class OtpViewController: UIViewController {
    
    @IBOutlet weak var btnOtpRegeneration: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var txt4: UITextField!
    @IBOutlet weak var txt3: UITextField!
    @IBOutlet weak var txt2: UITextField!
    @IBOutlet weak var txt1: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftAlignedTitleWithBack("OTP", target: self, action: #selector(otpBackBtnTapped))
        
        let allviews = [txt1!, txt2!, txt3!, txt4!]
        styleViews(allviews, cornerRadius: 12, borderWidth: 0, borderColor: UIColor.black.cgColor)
        setTextFieldPadding(allviews, left: 15, right: 22)
        
        for tf in allviews {
            tf.delegate = self
            tf.keyboardType = .numberPad
            tf.textAlignment = .center
        }
        
        btnNext.layer.cornerRadius = 28
        
    }
    
    @objc func otpBackBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnOtpRegenerationAction(_ sender: Any) {
        let alert = UIAlertController(title: "OTP Sent", message: "A new OTP has been sent to your registered mobile number.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnNextAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "UserLoginStoryboard", bundle: nil)
        if let mlvc = storyboard.instantiateViewController(identifier: "NewPasswordViewController") as? NewPasswordViewController {
            self.navigationController?.pushViewController(mlvc, animated: true)
        }
    }
}

extension OtpViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        guard allowedCharacters.isSuperset(of: characterSet) else {
            return false
        }
        
        if string.count > 1 {
            return false
        }
        
        if string.count == 1 {
            textField.text = string
            
            switch textField {
            case txt1:
                txt2.becomeFirstResponder()
            case txt2:
                txt3.becomeFirstResponder()
            case txt3:
                txt4.becomeFirstResponder()
            case txt4:
                txt4.resignFirstResponder()
            default:
                break
            }
            return false
        } else if string.isEmpty { // Backspace pressed
            switch textField {
            case txt4:
                txt3.becomeFirstResponder()
            case txt3:
                txt2.becomeFirstResponder()
            case txt2:
                txt1.becomeFirstResponder()
            default:
                break
            }
            textField.text = ""
            return false
        }
        return true
    }
}
