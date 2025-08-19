import UIKit

class WishlistTableViewCell: UITableViewCell {
    
    @IBOutlet weak var btnWishlist: UIButton!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    
    var productId: Int = 0
    var userEmail: String = ""
    var onWishlistToggle: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgProduct.layer.cornerRadius = 8
        imgProduct.clipsToBounds = true
    }
    
    func configure(with product: ProductModel, userEmail: String) {
        productId = product.intId
        self.userEmail = userEmail
        
        lblProductName.text = product.strProductName
        lblPrice.text = "₹\(product.doubleProductPrice)"
        lblCategory.text = product.objProductCategory.rawValue
        lblType.text = product.objProductType.rawValue
        
        // Load product image
        if product.strProductImage.hasPrefix("http") {
            if let imageUrl = URL(string: product.strProductImage) {
                URLSession.shared.dataTask(with: imageUrl) { [weak self] data, _, _ in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.imgProduct.image = image
                        }
                    } else {
                        DispatchQueue.main.async {
                            self?.imgProduct.image = UIImage(named: "placeholder")
                        }
                    }
                }.resume()
            }
        } else {
            imgProduct.image = UIImage(named: product.strProductImage) ?? UIImage(named: "placeholder")
        }
        
        // ✅ Use CoreData to check and show correct heart state
        let isInWishlist = CoreDataHelper.shared.isInWishlist(productId: product.intId, userEmail: userEmail)
        btnWishlist.setImage(UIImage(systemName: isInWishlist ? "heart.fill" : "heart"), for: .normal)
    }
    
    @IBAction func btnWishListAction(_ sender: Any) {
        if CoreDataHelper.shared.isInWishlist(productId: productId, userEmail: userEmail) {
            CoreDataHelper.shared.removeFromWishlist(productId: productId, userEmail: userEmail)
            btnWishlist.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            CoreDataHelper.shared.addToWishlist(productId: productId, userEmail: userEmail)
            btnWishlist.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        onWishlistToggle?()
    }
}
