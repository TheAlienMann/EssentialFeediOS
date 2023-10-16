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
    stackView.layer.borderColor = UIColor.black.cgColor
    stackView.layer.borderWidth = 1.0
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
    return label
  }()
  
  private(set) public lazy var pinImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(named: "pin", in: Bundle.module, with: nil)
    imageView.contentMode = .scaleAspectFit
    imageView.setContentHuggingPriority(.init(251.0), for: .horizontal)
    imageView.setContentHuggingPriority(.init(251.0), for: .vertical)
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
    label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    label.textColor = .secondaryLabel
    label.numberOfLines = 6
    label.textAlignment = .natural
    label.lineBreakMode = .byTruncatingTail
    label.lineBreakStrategy = .standard
    label.autoresizesSubviews = true
    label.adjustsFontSizeToFitWidth = false
    label.adjustsFontForContentSizeCategory = true
    label.font = UIFont.preferredFont(forTextStyle: .body)
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
    stack.addArrangedSubviews([locationContainerStackView, feedImageContainer, descriptionLabel])
    return stack
  }()
  
  var onRetry: (() -> Void)?
  var onReuse: (() -> Void)?
  
  public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
//    contentView.frame = CGRect(x: 0, y: 0, width: 414, height: 580)
    contentView.addSubview(containerVerticalStackView)
//    contentView.addSubview(locationContainerStackView)
    feedImageContainer.addSubview(feedImageView)
    feedImageContainer.addSubview(feedImageRetryButton)
    contentView.addSubview(locationLabel)
    contentView.addSubview(pinContainer)
    pinContainer.addSubview(pinImageView)
    
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupLayout() {
    NSLayoutConstraint.activate([
      containerVerticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      containerVerticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      containerVerticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      containerVerticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
      
      descriptionLabel.leadingAnchor.constraint(equalTo: containerVerticalStackView.leadingAnchor),
      descriptionLabel.bottomAnchor.constraint(equalTo: containerVerticalStackView.bottomAnchor),
      descriptionLabel.trailingAnchor.constraint(equalTo: containerVerticalStackView.trailingAnchor),
      descriptionLabel.heightAnchor.constraint(equalToConstant: 114),
      
      locationContainerStackView.leadingAnchor.constraint(equalTo: containerVerticalStackView.leadingAnchor),
      locationContainerStackView.topAnchor.constraint(equalTo: containerVerticalStackView.topAnchor),
      locationContainerStackView.trailingAnchor.constraint(equalTo: containerVerticalStackView.trailingAnchor),
//      locationContainerStackView.heightAnchor.constraint(equalTo: pinContainer.heightAnchor),
      
      pinContainer.leadingAnchor.constraint(equalTo: locationContainerStackView.leadingAnchor),
      pinContainer.topAnchor.constraint(equalTo: locationContainerStackView.topAnchor),
      pinContainer.widthAnchor.constraint(equalToConstant: 10),
      pinContainer.heightAnchor.constraint(equalToConstant: 38),
      
      pinImageView.leadingAnchor.constraint(equalTo: pinContainer.leadingAnchor),
      pinImageView.topAnchor.constraint(equalTo: pinContainer.topAnchor, constant: 3),
      pinImageView.widthAnchor.constraint(equalToConstant: 10),
      pinImageView.heightAnchor.constraint(equalToConstant: 14),
      
      locationLabel.trailingAnchor.constraint(equalTo: locationContainerStackView.trailingAnchor),
      locationLabel.leadingAnchor.constraint(equalTo: locationContainerStackView.leadingAnchor, constant: 16),
      locationLabel.bottomAnchor.constraint(equalTo: pinContainer.bottomAnchor),
      locationLabel.topAnchor.constraint(equalTo: pinContainer.topAnchor),
      
//      feedImageContainer.topAnchor.constraint(equalTo: locationContainerStackView.bottomAnchor, constant: 10),
//      feedImageContainer.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//      feedImageContainer.centerYAnchor.constraint(equalTo: containerVerticalStackView.centerYAnchor),
//      feedImageContainer.leadingAnchor.constraint(equalTo: containerVerticalStackView.leadingAnchor),
//      feedImageContainer.trailingAnchor.constraint(equalTo: containerVerticalStackView.trailingAnchor),
      feedImageContainer.widthAnchor.constraint(equalToConstant: 374),
      feedImageContainer.heightAnchor.constraint(equalToConstant: 374),
      
      feedImageView.widthAnchor.constraint(equalTo: feedImageContainer.widthAnchor),
      feedImageView.heightAnchor.constraint(equalTo: feedImageContainer.heightAnchor),
      feedImageView.centerXAnchor.constraint(equalTo: feedImageContainer.centerXAnchor),
      feedImageView.centerYAnchor.constraint(equalTo: feedImageContainer.centerYAnchor),
      
      feedImageRetryButton.widthAnchor.constraint(equalTo: feedImageContainer.widthAnchor),
      feedImageRetryButton.heightAnchor.constraint(equalTo: feedImageContainer.heightAnchor),
      feedImageRetryButton.centerXAnchor.constraint(equalTo: feedImageContainer.centerXAnchor),
      feedImageRetryButton.centerYAnchor.constraint(equalTo: feedImageContainer.centerYAnchor),
    ])
  }
  
  @objc private func retryButtonTapped() {
    onRetry?()
  }
  
  public override func prepareForReuse() {
    super.prepareForReuse()
    
    onReuse?()
  }
}
