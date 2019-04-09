import Foundation
import UIKit
import SDWebImage
extension UIImageView {
    func downloaded(from link: String) {
        guard let url = URL(string: link) else { return }
        self.sd_setImage(with:url, completed: nil)
    }
}
