import Foundation
import UIKit

extension UITableView {
  func register<T: UITableViewCell>(cell name: T.Type) {
    register(T.self, forCellReuseIdentifier: String(describing: name))
  }
}
