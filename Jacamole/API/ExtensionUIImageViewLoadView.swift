import UIKit

public extension UIImageView {
    
    func load(urlAdress: String) {
        let url = URL(string: urlAdress)!
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
