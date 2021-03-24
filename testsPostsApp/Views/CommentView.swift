//
//  CommentView.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 24/3/21.
//

import UIKit

struct CommentViewData {
  let email: String
  let title: String
  let body: String
}

class CommentView: UIView {

  // MARK: - Constants

  private struct ViewTraits {
    // Margins
    static let contentMargin: CGFloat = 10.0
    static let contentSpacing: CGFloat = 18.0
    static let labelsSpacing: CGFloat = 10.0

    // Sizes
    static let userImageSize: CGFloat = 30.0

    // Fonts
    static let emailFontSize: CGFloat = 10.0
    static let titleFontSize: CGFloat = 16.0
    static let bodyFontSize: CGFloat = 11.0
  }

  // MARK: - Properties

  private let contentStackView = UIStackView()
  private let userImageView = UIImageView()
  private let labelsStackView = UIStackView()
  private let emailLabel = UILabel()
  private let titleLabel = UILabel()
  private let bodyLabel = UILabel()

  // MARK: - Lifecycle

  override func layoutSubviews() {
    super.layoutSubviews()
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.33
    layer.shadowOffset = CGSize(width: 0, height: 7)
    layer.shadowRadius = 7
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupComponents()
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Public

  func setupUI(data: CommentViewData) {
    emailLabel.text = data.email
    titleLabel.text = data.title
    bodyLabel.text = data.title
  }

  private func setupComponents() {
    backgroundColor = .customBlue

    layer.cornerRadius = 7.0
    layer.borderColor = .none

    contentStackView.axis = .horizontal
    contentStackView.alignment = .leading
    contentStackView.distribution = .fillProportionally
    contentStackView.spacing = ViewTraits.contentSpacing

    labelsStackView.axis = .vertical
    labelsStackView.alignment = .fill
    labelsStackView.distribution = .equalSpacing
    labelsStackView.spacing = ViewTraits.labelsSpacing

    userImageView.image = UIImage(named: "profile_icon")
    userImageView.contentMode = .scaleAspectFit
    userImageView.backgroundColor = .customWhite
    userImageView.layer.masksToBounds = true
    userImageView.layer.cornerRadius = 15.0
    userImageView.layer.borderColor = UIColor.customWhite.cgColor
    userImageView.layer.borderWidth = 1.0

    emailLabel.lineBreakMode = .byWordWrapping
    emailLabel.numberOfLines = 0
    emailLabel.font = UIFont(name: "SF-Pro", size: ViewTraits.emailFontSize)
    emailLabel.textAlignment = .left
    emailLabel.textColor = .darkGray

    titleLabel.lineBreakMode = .byWordWrapping
    titleLabel.numberOfLines = 0
    titleLabel.font = UIFont(name: "SF-Pro", size: ViewTraits.titleFontSize)
    titleLabel.textAlignment = .left
    titleLabel.textColor = .customBlack

    bodyLabel.lineBreakMode = .byWordWrapping
    bodyLabel.numberOfLines = 0
    bodyLabel.font = UIFont(name: "SF-Pro", size: ViewTraits.bodyFontSize)
    bodyLabel.textAlignment = .left
    bodyLabel.textColor = .customWhite

    labelsStackView.addArrangedSubview(emailLabel)
    labelsStackView.addArrangedSubview(titleLabel)
    labelsStackView.addArrangedSubview(bodyLabel)

    contentStackView.addArrangedSubview(userImageView)
    contentStackView.addArrangedSubview(labelsStackView)

    addSubviewForAutolayout(contentStackView)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      contentStackView.topAnchor.constraint(equalTo: topAnchor, constant: ViewTraits.contentMargin),
      contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ViewTraits.contentMargin),
      contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -ViewTraits.contentMargin),
      contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -ViewTraits.contentMargin),

      userImageView.heightAnchor.constraint(equalToConstant: ViewTraits.userImageSize),
      userImageView.widthAnchor.constraint(equalToConstant: ViewTraits.userImageSize)
    ])
  }
}
