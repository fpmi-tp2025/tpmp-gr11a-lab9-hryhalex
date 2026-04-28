import UIKit

struct Medicine: Codable {
    let id: Int
    let name: String
    let description: String
    let composition: String
    let imageName: String
    let price: Double
    
    var image: UIImage? {
        return UIImage(named: imageName)
    }
}
