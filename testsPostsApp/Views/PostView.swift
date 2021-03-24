//
//  PostView.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 24/3/21.
//

import UIKit

struct PostViewData {
  let title: String
  let body: String
  let username: String
  let totalComments: Int
  let hideTotalComments: Bool
}

class PostView: UIView {

  // MARK: - Constants

  private struct ViewTraits {
    // Margins
    static let contentMargin: CGFloat = 12.0
    static let contentBottomMargin: CGFloat = 10.0
    static let labelsSpacing: CGFloat = 12.0
    static let userViewSpacing: CGFloat = 8.0

    // Sizes
    static let userImageSize: CGFloat = 30.0

    // Fonts
    static let titleFontSize: CGFloat = 16.0
    static let bodyFontSize: CGFloat = 11.0
    static let totalCommentsFontSize: CGFloat = 11.0
    static let usernameFontSize: CGFloat = 16.0
  }

  // MARK: - Properties

  private let userView = UIStackView()
  private let userImageView = UIImageView()
  private let usernameLabel = UILabel()
  private let labelsStackView = UIStackView()
  private let titleLabel = UILabel()
  private let bodyLabel = UILabel()
  private let totalCommentsLabel = UILabel()

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

  func setupUI(data: PostViewData) {
    titleLabel.text = data.title
    bodyLabel.text = data.body
    usernameLabel.text = data.username
    totalCommentsLabel.isHidden = data.hideTotalComments
    totalCommentsLabel.text = "\(data.totalComments) comment(s)"
  }

  private func setupComponents() {
    backgroundColor = .customBlue

    layer.cornerRadius = 7.0
    layer.borderColor = .none

    labelsStackView.axis = .vertical
    labelsStackView.alignment = .fill
    labelsStackView.distribution = .equalSpacing
    labelsStackView.spacing = ViewTraits.labelsSpacing

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

    userView.axis = .horizontal
    userView.alignment = .fill
    userView.distribution = .fill
    userView.spacing = ViewTraits.userViewSpacing

    userImageView.image = UIImage(named: "profile_icon")
    userImageView.contentMode = .scaleAspectFit
    userImageView.backgroundColor = .customWhite
    userImageView.layer.masksToBounds = true
    userImageView.layer.cornerRadius = 15.0
    userImageView.layer.borderColor = UIColor.customWhite.cgColor
    userImageView.layer.borderWidth = 1.0

    usernameLabel.lineBreakMode = .byWordWrapping
    usernameLabel.numberOfLines = 0
    usernameLabel.font = UIFont(name: "SF-Pro", size: ViewTraits.usernameFontSize)
    usernameLabel.textAlignment = .left
    usernameLabel.textColor = .customBlack

    totalCommentsLabel.lineBreakMode = .byWordWrapping
    totalCommentsLabel.numberOfLines = 0
    totalCommentsLabel.font = UIFont(name: "SF-Pro", size: ViewTraits.totalCommentsFontSize)
    totalCommentsLabel.textAlignment = .left
    totalCommentsLabel.textColor = .darkGray

    userView.addArrangedSubview(userImageView)
    userView.addArrangedSubview(usernameLabel)

    labelsStackView.addArrangedSubview(titleLabel)
    labelsStackView.addArrangedSubview(bodyLabel)
    labelsStackView.addArrangedSubview(totalCommentsLabel)

    addSubviewForAutolayout(userView)
    addSubviewForAutolayout(labelsStackView)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      userView.topAnchor.constraint(equalTo: topAnchor, constant: ViewTraits.contentMargin),
      userView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ViewTraits.contentMargin),
      userView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -ViewTraits.contentMargin),

      userImageView.heightAnchor.constraint(equalToConstant: ViewTraits.userImageSize),
      userImageView.widthAnchor.constraint(equalToConstant: ViewTraits.userImageSize),

      labelsStackView.topAnchor.constraint(equalTo: userView.bottomAnchor, constant: ViewTraits.contentMargin),
      labelsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ViewTraits.contentMargin),
      labelsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -ViewTraits.contentMargin),
      labelsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -ViewTraits.contentBottomMargin)

    ])
  }
}
