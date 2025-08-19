import UIKit

class WishlistViewController: UIViewController {
    
    var wishlistProducts: [ProductModel] = []
    var currentUserEmail: String = ""
    
    @IBOutlet weak var lblEmpty: UILabel!
    @IBOutlet weak var tblWishlist: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentUserEmail = UserDefaults.standard.string(forKey: "currentUserEmail") ?? ""
        
        tblWishlist.delegate = self
        tblWishlist.dataSource = self
        tblWishlist.register(UINib(nibName: "WishlistTableViewCell", bundle: nil), forCellReuseIdentifier: "WishlistTableViewCell")
        
        loadWishlist()
        setLeftAlignedTitleWithBack("WishList", target: self, action: #selector(backBtnTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadWishlist()
    }
    
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func loadWishlist() {
        
        wishlistProducts = CoreDataHelper.shared.fetchWishlistProducts(for: currentUserEmail)
        tblWishlist.reloadData()
        lblEmpty.isHidden = !wishlistProducts.isEmpty
        tblWishlist.isHidden = wishlistProducts.isEmpty
    }
}
