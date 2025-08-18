//
//  FoodDetailViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 10/08/25.
//

import UIKit

class FoodDetailViewController: UIViewController {
    
    @IBOutlet weak var btnWishlist: UIButton!
    @IBOutlet weak var btnDropDownPortions: UIButton!
    @IBOutlet weak var btnDropDownIngredients: UIButton!
    @IBOutlet weak var viewFoodDetailContent: UIScrollView!
    @IBOutlet weak var stackRating: UIStackView!
    @IBOutlet weak var lblTotalPice: UILabel!
    @IBOutlet weak var btnAddtoCart: UIButton!
    @IBOutlet weak var imgFood: UIImageView!
    @IBOutlet weak var lblNimberOfPortion: UILabel!
    @IBOutlet weak var btnPortionIncrease: UIButton!
    @IBOutlet weak var btnPortionReduce: UIButton!
    @IBOutlet weak var txtSelectIngridients: UITextField!
    @IBOutlet weak var txtSizeOfPortions: UITextField!
    @IBOutlet weak var lblFoodDescription: UILabel!
    @IBOutlet weak var lblFoodPrize: UILabel!
    @IBOutlet weak var lblFoodName: UILabel!
    
    private var appDelegate: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    var product: ProductModel?
    var quantity: Int = 1
    var cartItems: [(product: ProductModel, quantity: Int)] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let product = product,
              let currentUserEmail = UserDefaults.standard.string(forKey: "currentUser") else { return }
        
        let userWishlist = loadWishlist(forUser: currentUserEmail)
        if userWishlist.contains(where: { $0.intId == product.intId }) {
            btnWishlist.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            btnWishlist.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let allviews = [btnPortionReduce!, btnPortionIncrease!]
        styleViews(allviews, cornerRadius: 15, borderWidth: 0, borderColor: UIColor.black.cgColor)
        styleViews([lblNimberOfPortion], cornerRadius: 15, borderWidth: 1, borderColor: UIColor.loginButton.cgColor)
        setTextFieldPadding([txtSelectIngridients!, txtSizeOfPortions!])
        btnAddtoCart.layer.cornerRadius = 7.42
        viewFoodDetailContent.layer.cornerRadius = 42
        viewFoodDetailContent.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewFoodDetailContent.clipsToBounds = true
        
        styleViews([btnDropDownPortions!, btnDropDownIngredients!, txtSizeOfPortions!, txtSelectIngridients!], cornerRadius: 4, borderWidth: 0, borderColor: UIColor.white.cgColor)
        
        btnDropDownIngredients.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        btnDropDownPortions.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        txtSizeOfPortions.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        txtSelectIngridients.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        quantity = 1
        lblNimberOfPortion.text = "\(quantity)"
        btnPortionReduce.isEnabled = false
        
        setLeftAlignedTitleWithBack("Food Detail", target: self, action: #selector(detailBackBtnTapped))
        setCartButton(target: self, action: #selector(cartBtnTapped))
        configureUI()
        
        if let product = product,
           let currentUserEmail = UserDefaults.standard.string(forKey: "currentUser") {
            let userWishlist = loadWishlist(forUser: currentUserEmail)
            if userWishlist.contains(where: { $0.intId == product.intId }) {
                btnWishlist.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            } else {
                btnWishlist.setImage(UIImage(systemName: "heart"), for: .normal)
            }
        }
        
    }
    
    func configureUI() {
        guard let product = product else { return }
        lblFoodName.text = product.strProductName
        lblFoodDescription.text = product.strProductDescription
        imgFood.image = UIImage(named: product.strProductImage)
        updatePriceAndQuantityUI()
    }
    
    func updatePriceAndQuantityUI() {
        guard let product = product else { return }
        let total = product.doubleProductPrice * Double(quantity)
        lblFoodPrize.text = "$\(String(format: "%.2f", product.doubleProductPrice))"
        lblTotalPice.text = "$\(String(format: "%.2f", total))"
        lblNimberOfPortion.text = "\(quantity)"
        btnPortionReduce.isEnabled = quantity > 1
    }
    
    @objc func detailBackBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAddToCartAction(_ sender: Any) {
        guard let product = product else { return }
        
        checkProduct(productToAdd: product)
        let alert = UIAlertController(title: "Success", message: "Added to cart!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnPortionDecreaseAction(_ sender: Any) {
        if quantity > 1 {
            quantity -= 1
            updatePriceAndQuantityUI()
        }
    }
    
    @IBAction func btnPortionIncreaseAction(_ sender: Any) {
        quantity += 1
        updatePriceAndQuantityUI()
    }
    
    func checkProduct(productToAdd: ProductModel) {
        guard let appDelegate = appDelegate else { return }
        
        if let existingIndex = appDelegate.arrCart.firstIndex(where: { $0.intId == productToAdd.intId }) {
            appDelegate.arrCart[existingIndex].intProductQty! += quantity
            print("Updated \(productToAdd.strProductName) quantity to \(appDelegate.arrCart[existingIndex].intProductQty ?? 0).")
        } else {
            let newProduct = productToAdd
            newProduct.intProductQty = quantity
            appDelegate.arrCart.append(newProduct)
            print("Added \(productToAdd.strProductName) with quantity \(quantity).")
        }
        
        let cartDictArray = appDelegate.arrCart.map { productToDict($0) }
        saveCartToUserDefaults(cartArray: cartDictArray)
    }
    
    @IBAction func btnDropDownPortionAction(_ sender: Any) {
    }
    
    @IBAction func btnDropDownIngredientsAction(_ sender: Any) {
    }
    
    @objc func cartBtnTapped() {
        let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            self.navigationController?.pushViewController(menuVC, animated: true)
        }
    }
    
    @IBAction func btnWishlistAction(_ sender: Any) {
        guard let product  = product else { return }
        guard let currentUserEmail = UserDefaults.standard.string(forKey: "currentUser") else { return }
        
        var wishlist = loadWishlist(forUser: currentUserEmail)
        
        if let index = wishlist.firstIndex(where: { $0.intId == product.intId }) {
            wishlist.remove(at: index)
            btnWishlist.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            wishlist.append(product)
            btnWishlist.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        
        saveWishlist(wishlist, forUser: currentUserEmail)
    }
}
