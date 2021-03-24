//
//  PostTableViewCell.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 23/3/21.
//

import UIKit

struct PostTableViewCellData {
  let title: String
  let body: String
  let username: String
  let totalComments: Int
}

class PostTableViewCell: UITableViewCell {

  // MARK: - Constants

  private struct ViewTraits {
    // Margins
    static let contentMargin: CGFloat = 12.0
    static let contentBottomMargin: CGFloat = 10.0
    static let postViewMargin: CGFloat = 18.0
    static let titleTopMargin: CGFloat = 10.0
    static let bodyTopMargin: CGFloat = 10.0
    static let totalCommentsTopMargin: CGFloat = 16.0
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

  private let postView = UIView()
  private let userView = UIStackView()
  private let userImageView = UIImageView()
  private let usernameLabel = UILabel()
  private let titleLabel = UILabel()
  private let bodyLabel = UILabel()
  private let totalCommentsLabel = UILabel()

  // MARK: - Lifecycle

  override func layoutSubviews() {
    super.layoutSubviews()
    postView.layer.shadowColor = UIColor.black.cgColor
    postView.layer.shadowOpacity = 0.33
    postView.layer.shadowOffset = CGSize(width: 0, height: 7)
    postView.layer.shadowRadius = 7
  }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupComponents()
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Public

  func setupUI(data: PostTableViewCellData) {
    titleLabel.text = data.title
    bodyLabel.text = data.body
    usernameLabel.text = data.username
    totalCommentsLabel.text = "\(data.totalComments) comment(s)"
  }

  private func setupComponents() {
    backgroundColor = .clear

    postView.backgroundColor = .customBlue
    postView.layer.cornerRadius = 7.0
    postView.layer.borderColor = .none

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

    postView.addSubviewForAutolayout(userView)
    postView.addSubviewForAutolayout(titleLabel)
    postView.addSubviewForAutolayout(bodyLabel)
    postView.addSubviewForAutolayout(totalCommentsLabel)

    contentView.addSubviewForAutolayout(postView)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      postView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ViewTraits.postViewMargin),
      postView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ViewTraits.postViewMargin),
      postView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -ViewTraits.postViewMargin),
      postView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -ViewTraits.postViewMargin),

      userView.topAnchor.constraint(equalTo: postView.topAnchor, constant: ViewTraits.contentMargin),
      userView.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: ViewTraits.contentMargin),
      userView.trailingAnchor.constraint(equalTo: postView.trailingAnchor, constant: -ViewTraits.contentMargin),

      userImageView.heightAnchor.constraint(equalToConstant: ViewTraits.userImageSize),
      userImageView.widthAnchor.constraint(equalToConstant: ViewTraits.userImageSize),

      titleLabel.topAnchor.constraint(equalTo: userView.bottomAnchor, constant: ViewTraits.titleTopMargin),
      titleLabel.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: ViewTraits.contentMargin),
      titleLabel.trailingAnchor.constraint(equalTo: postView.trailingAnchor, constant: -ViewTraits.contentMargin),

      bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: ViewTraits.bodyTopMargin),
      bodyLabel.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: ViewTraits.contentMargin),
      bodyLabel.trailingAnchor.constraint(equalTo: postView.trailingAnchor, constant: -ViewTraits.contentMargin),

      totalCommentsLabel.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor,
                                              constant: ViewTraits.totalCommentsTopMargin),
      totalCommentsLabel.leadingAnchor.constraint(equalTo: postView.leadingAnchor,
                                                  constant: ViewTraits.contentMargin),
      totalCommentsLabel.trailingAnchor.constraint(equalTo: postView.trailingAnchor,
                                                   constant: -ViewTraits.contentMargin),
      totalCommentsLabel.bottomAnchor.constraint(equalTo: postView.bottomAnchor,
                                                 constant: -ViewTraits.contentBottomMargin)
    ])
  }
}
