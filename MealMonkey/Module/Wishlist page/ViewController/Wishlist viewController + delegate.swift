import UIKit

extension WishlistViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishlistProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WishlistTableViewCell", for: indexPath) as! WishlistTableViewCell
        let product = wishlistProducts[indexPath.row]
        cell.configure(with: product, userEmail: currentUserEmail)
        cell.onWishlistToggle = { [weak self] in self?.loadWishlist() }
        return cell
    }
}
