import Foundation
import UIKit

public final class FeedImageCell: UITableViewCell {
  
  static let identifier = String(describing: FeedImageCell.self)
  
  private(set) public lazy var locationContainerStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.spacing = 6
    stackView.alignment = .top
    stackView.distribution = .fill
    stackView.addArrangedSubviews([pinContainer, locationLabel])
    stackView.clearsContextBeforeDrawing = true
    stackView.autoresizesSubviews = true
//    stackView.layer.borderColor = UIColor.black.cgColor
//    stackView.layer.borderWidth = 1.0
    return stackView
  }()
  
  private(set) public lazy var pinContainer: UIView = {
    let view = UIView()
//    view.backgroundColor = .clear
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleToFill
    view.isOpaque = true
    view.clearsContextBeforeDrawing = true
    view.autoresizesSubviews = true
    view.addSubview(pinImageView)
    view.addSubview(locationLabel)
    return view
  }()
  
  private(set) public lazy var locationLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .natural
    label.numberOfLines = 2
    label.lineBreakMode = .byTruncatingTail
    label.lineBreakStrategy = .standard
    label.textColor = .secondaryLabel
    label.adjustsFontForContentSizeCategory = true
    label.adjustsFontSizeToFitWidth = false
    label.font = UIFont.preferredFont(forTextStyle: .subheadline)
    label.setContentHuggingPriority(.init(251.0), for: .horizontal)
    label.setContentHuggingPriority(.init(251.0), for: .vertical)
    label.setContentCompressionResistancePriority(.init(750), for: .horizontal)
    label.setContentCompressionResistancePriority(.init(750), for: .vertical)
    return label
  }()
  
  private(set) public lazy var pinImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(named: "pin", in: Bundle.module, with: nil)
    imageView.contentMode = .scaleAspectFit
    imageView.setContentHuggingPriority(.init(251.0), for: .horizontal)
    imageView.setContentHuggingPriority(.init(251.0), for: .vertical)
    imageView.setContentCompressionResistancePriority(.init(750), for: .horizontal)
    imageView.setContentCompressionResistancePriority(.init(750), for: .vertical)
    return imageView
  }()
  
  private(set) public lazy var feedImageContainer: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleToFill
    view.isUserInteractionEnabled = true
    view.backgroundColor = .secondarySystemBackground
    view.isOpaque = true
    view.autoresizesSubviews = true
    view.clipsToBounds = true
    view.clearsContextBeforeDrawing = true
    view.layer.cornerRadius = 22.0
    view.addSubview(feedImageView)
    view.addSubview(feedImageRetryButton)
    return view
  }()
  
  private(set) public lazy var feedImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.autoresizesSubviews = true
    imageView.clearsContextBeforeDrawing = true
    imageView.isOpaque = true
    
    return imageView
  }()
  
  private(set) public lazy var feedImageRetryButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("↻", for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 60.0)
    button.setTitleColor(.systemBackground, for: .normal)
    button.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
    button.autoresizesSubviews = true
    button.clearsContextBeforeDrawing = true
    button.isOpaque = false
    button.contentMode = .scaleToFill
    return button
  }()
  
  private(set) public lazy var descriptionLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.textColor = .secondaryLabel
    label.numberOfLines = 6
    label.textAlignment = .natural
    label.lineBreakMode = .byTruncatingTail
    label.lineBreakStrategy = .standard
    label.autoresizesSubviews = true
    label.adjustsFontSizeToFitWidth = false
    label.adjustsFontForContentSizeCategory = true
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.setContentHuggingPriority(.init(251), for: .horizontal)
    label.setContentHuggingPriority(.init(251), for: .vertical)
    label.setContentCompressionResistancePriority(.init(750), for: .horizontal)
    label.setContentCompressionResistancePriority(.init(750), for: .vertical)
    return label
  }()
  
  private lazy var containerVerticalStackView: UIStackView = {
    let stack = UIStackView()
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.axis = .vertical
    stack.alignment = .leading
    stack.spacing = 10
    stack.contentMode = .scaleToFill
    stack.distribution = .fill
    stack.isUserInteractionEnabled = true
    stack.clearsContextBeforeDrawing = true
    stack.autoresizesSubviews = true
    stack.semanticContentAttribute = .unspecified
    stack.addArrangedSubviews([locationContainerStackView, feedImageContainer, descriptionLabel])
    return stack
  }()
  
  var onRetry: (() -> Void)?
  var onReuse: (() -> Void)?
  
  public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    contentView.addSubview(containerVerticalStackView)
    
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupLayout() {
    NSLayoutConstraint(item: contentView, attribute: .trailingMargin, relatedBy: .equal, toItem: containerVerticalStackView, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
    // priority 999
    NSLayoutConstraint(item: contentView, attribute: .bottomMargin, relatedBy: .equal, toItem: containerVerticalStackView, attribute: .bottom, multiplier: 1, constant: 6).isActive = true
    NSLayoutConstraint(item: containerVerticalStackView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leadingMargin, multiplier: 1, constant: 0).isActive = true
    // priority 999
    NSLayoutConstraint(item: containerVerticalStackView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .topMargin, multiplier: 1, constant: 6).isActive = true
    NSLayoutConstraint(item: locationContainerStackView, attribute: .width, relatedBy: .equal, toItem: containerVerticalStackView, attribute: .width, multiplier: 1, constant: 0).isActive = true
    NSLayoutConstraint(item: feedImageContainer, attribute: .width, relatedBy: .equal, toItem: containerVerticalStackView, attribute: .width, multiplier: 1, constant: 0).isActive = true
    
    NSLayoutConstraint(item: feedImageContainer, attribute: .width, relatedBy: .equal, toItem: feedImageContainer, attribute: .height, multiplier: 1, constant: 0).isActive = true
    NSLayoutConstraint(item: feedImageContainer, attribute: .trailing, relatedBy: .equal, toItem: feedImageRetryButton, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
    NSLayoutConstraint(item: feedImageRetryButton, attribute: .top, relatedBy: .equal, toItem: feedImageContainer, attribute: .top, multiplier: 1, constant: 0).isActive = true
    NSLayoutConstraint(item: feedImageContainer, attribute: .bottom, relatedBy: .equal, toItem: feedImageRetryButton, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
    NSLayoutConstraint(item: feedImageRetryButton, attribute: .leading, relatedBy: .equal, toItem: feedImageContainer, attribute: .leading, multiplier: 1, constant: 0).isActive = true
    NSLayoutConstraint(item: feedImageView, attribute: .top, relatedBy: .equal, toItem: feedImageContainer, attribute: .top, multiplier: 1, constant: 0).isActive = true
    NSLayoutConstraint(item: feedImageView, attribute: .leading, relatedBy: .equal, toItem: feedImageContainer, attribute: .leading, multiplier: 1, constant: 0).isActive = true
    NSLayoutConstraint(item: feedImageContainer, attribute: .trailing, relatedBy: .equal, toItem: feedImageView, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
    NSLayoutConstraint(item: feedImageContainer, attribute: .bottom, relatedBy: .equal, toItem: feedImageView, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
    
    NSLayoutConstraint(item: pinContainer, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 10).isActive = true
    NSLayoutConstraint(item: pinImageView, attribute: .leading, relatedBy: .equal, toItem: pinContainer, attribute: .leading, multiplier: 1, constant: 0).isActive = true
    NSLayoutConstraint(item: pinImageView, attribute: .top, relatedBy: .equal, toItem: pinContainer, attribute: .top, multiplier: 1, constant: 3).isActive = true
    
    NSLayoutConstraint(item: pinImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 14).isActive = true
    
  }
  
  @objc private func retryButtonTapped() {
    onRetry?()
  }
  
  public override func prepareForReuse() {
    super.prepareForReuse()
    
    onReuse?()
  }
}
