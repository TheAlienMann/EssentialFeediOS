import Foundation
import UIKit

extension UIImageView {
  func setImageAnimated(_ newImage: UIImage?) {
    image = newImage
    
    guard newImage != nil else { return }
    
    alpha = 0
    UIView.animate(withDuration: 0.25, animations: {
      self.alpha = 1
    })
  }
}
