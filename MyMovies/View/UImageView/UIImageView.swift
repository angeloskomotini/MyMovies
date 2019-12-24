import Foundation
import UIKit
import SDWebImage
extension UIImageView {
    func downloaded(link: String) {
        let url = URL(string: link) 
        self.sd_setImage(with:url, completed: nil)
    }
}
