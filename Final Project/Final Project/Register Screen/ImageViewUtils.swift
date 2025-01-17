import Foundation
import UIKit

extension UIImageView {
    // load the data as image into the UIImageView
    func loadRemoteImage(from url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self?.image = UIImage(data: data)
                }
                
            }
        }
    }
}
