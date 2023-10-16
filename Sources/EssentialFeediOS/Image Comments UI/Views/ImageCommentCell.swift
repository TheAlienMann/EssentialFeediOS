import Foundation
import UIKit

public final class ImageCommentCell: UITableViewCell {
  
  lazy var usernameDateContainer: UIStackView = {
    let stack = UIStackView()
//    let stack = UIStackView(frame: CGRect(x: 0, y: 0, width: 374, height: 20.5))
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.axis = .horizontal
    stack.spacing = 8
    stack.alignment = .fill
    stack.distribution = .fill
    stack.contentMode = .scaleToFill
    stack.autoresizesSubviews = true
    stack.semanticContentAttribute = .unspecified
    stack.insetsLayoutMarginsFromSafeArea = true
    return stack
  }()
  
  lazy var messageContainer: UIStackView = {
    let stack = UIStackView()
//    let stack = UIStackView(frame: CGRect(x: 20, y: 11, width: 374, height: 103))
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.axis = .vertical
    stack.spacing = 8
    stack.alignment = .leading
    stack.distribution = .fill
    stack.contentMode = .scaleToFill
    stack.semanticContentAttribute = .unspecified
    stack.isUserInteractionEnabled = false
    stack.autoresizesSubviews = true
    stack.insetsLayoutMarginsFromSafeArea = true
    return stack
  }()
  
  private(set) public lazy var usernameLabel: UILabel = {
    let label = UILabel(frame: .zero)
//    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 79.5, height: 20.5))
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 1
    label.font = UIFont.preferredFont(forTextStyle: .headline)
    label.adjustsFontSizeToFitWidth = false
    label.textAlignment = .natural
    label.lineBreakMode = .byTruncatingTail
    label.textColor = .label
    label.baselineAdjustment = .alignBaselines
    label.insetsLayoutMarginsFromSafeArea = true
    label.adjustsFontForContentSizeCategory = true
    label.text = "username"
    label.contentMode = .left
    label.setContentHuggingPriority(.init(252.0), for: .horizontal)
    label.setContentHuggingPriority(.init(251.0), for: .vertical)
    label.setContentCompressionResistancePriority(.init(749), for: .horizontal)
    label.setContentCompressionResistancePriority(.init(750), for: .horizontal)
    return label
  }()
  
  private(set) public lazy var dateLabel: UILabel = {
    let label = UILabel(frame: .zero)
//    let label = UILabel(frame: CGRect(x: 87.5, y: 0, width: 286.5, height: 20.5))
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .secondaryLabel
    label.numberOfLines = 1
    label.contentMode = .left
    label.adjustsFontSizeToFitWidth = false
    label.adjustsFontForContentSizeCategory = true
    label.text = "date"
    label.insetsLayoutMarginsFromSafeArea = true
    label.textAlignment = .right
    label.baselineAdjustment = .alignBaselines
    label.font = UIFont.preferredFont(forTextStyle: .subheadline)
    label.setContentHuggingPriority(.init(250.0), for: .horizontal)
    label.setContentHuggingPriority(.init(251.0), for: .vertical)
    label.setContentCompressionResistancePriority(.init(751), for: .horizontal)
    label.setContentCompressionResistancePriority(.init(750), for: .horizontal)
    return label
  }()
  
  private(set) public lazy var messageLabel: UILabel = {
    let label = UILabel(frame: .zero)
//    let label = UILabel(frame: CGRect(x: 0, y: 28.5, width: 305.5, height: 74.5))
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .label
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.numberOfLines = 0
    label.textAlignment = .natural
    label.contentMode = .left
    label.adjustsFontSizeToFitWidth = false
    label.adjustsFontForContentSizeCategory = true
    label.insetsLayoutMarginsFromSafeArea = true
    label.baselineAdjustment = .alignBaselines
    label.lineBreakMode = .byTruncatingTail
    label.lineBreakStrategy = .standard
    label.setContentHuggingPriority(.init(251.0), for: .horizontal)
    label.setContentHuggingPriority(.init(251.0), for: .vertical)
    label.setContentCompressionResistancePriority(.init(750), for: .horizontal)
    label.setContentCompressionResistancePriority(.init(750), for: .horizontal)
    return label
  }()
  
  public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: String(describing: ImageCommentCell.self))
    usernameDateContainer.addArrangedSubviews([usernameLabel, dateLabel])
    messageContainer.addArrangedSubviews([usernameDateContainer, messageLabel])
    
    contentView.addSubview(messageContainer)
    NSLayoutConstraint(item: contentView, attribute: .bottomMargin, relatedBy: .equal, toItem: messageContainer, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
    NSLayoutConstraint(item: contentView, attribute: .trailingMargin, relatedBy: .equal, toItem: messageContainer, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
    NSLayoutConstraint(item: messageContainer, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leadingMargin, multiplier: 1, constant: 0).isActive = true
    NSLayoutConstraint(item: messageContainer, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .topMargin, multiplier: 1, constant: 0).isActive = true
    
    NSLayoutConstraint(item: messageContainer, attribute: .trailing, relatedBy: .equal, toItem: usernameDateContainer, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
    NSLayoutConstraint(item: usernameDateContainer, attribute: .leading, relatedBy: .equal, toItem: messageContainer, attribute: .leading, multiplier: 1, constant: 0).isActive = true
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
