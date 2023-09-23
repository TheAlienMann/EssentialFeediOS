import Foundation
import UIKit

public final class ImageCommentCell: UITableViewCell {
  
  lazy var usernameDateContainer: UIStackView = {
    let stack = UIStackView()
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.axis = .horizontal
    stack.spacing = 8
    stack.alignment = .fill
    stack.distribution = .fill
    stack.contentMode = .scaleToFill
    stack.autoresizesSubviews = true
    return stack
  }()
  
  lazy var messageContainer: UIStackView = {
    let stack = UIStackView()
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.axis = .vertical
    stack.spacing = 8
    stack.alignment = .leading
    stack.distribution = .fill
    stack.contentMode = .scaleToFill
    return stack
  }()
  
  private(set) public lazy var usernameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 1
    label.font = UIFont.preferredFont(forTextStyle: .headline)
    label.adjustsFontSizeToFitWidth = true
    label.textAlignment = .natural
    label.lineBreakMode = .byTruncatingTail
    label.textColor = .label
    label.text = "username"
    return label
  }()
  
  private(set) public lazy var dateLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .secondaryLabel
    label.numberOfLines = 1
    label.textAlignment = .right
    label.baselineAdjustment = .alignBaselines
    label.font = UIFont.preferredFont(forTextStyle: .subheadline)
    return label
  }()
  
  private(set) public lazy var messageLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .label
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.numberOfLines = 0
    label.textAlignment = .natural
    return label
  }()
  
  public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: String(describing: ImageCommentCell.self))
    usernameDateContainer.addArrangedSubviews([usernameLabel, dateLabel])
    messageContainer.addArrangedSubviews([usernameDateContainer, messageLabel])
    
    contentView.addSubview(messageContainer)
    NSLayoutConstraint.activate([
      messageContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      messageContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      messageContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      messageContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
