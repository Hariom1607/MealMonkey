import Foundation

class ProductAPIHelper {
    static let shared = ProductAPIHelper()
    private init() {}

    private let apiURL = "https://mocki.io/v1/e60bf567-b729-48c3-a316-d23b8a0ea24b"

    func fetchProducts(completion: @escaping ([ProductModel]?) -> Void) {
        guard let url = URL(string: apiURL) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            do {
                let response = try JSONDecoder().decode(ProductResponse.self, from: data)
                completion(response.products)
            } catch {
                print("Decoding error:", error)
                completion(nil)
            }
        }.resume()
    }
}

// Response class
class ProductResponse: Codable {
    var products: [ProductModel] = []
    var productTypes: [ProductType] = []
    var productCategories: [ProductCategory] = []
}
