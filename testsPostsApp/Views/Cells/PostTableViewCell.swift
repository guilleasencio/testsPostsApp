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
}

class PostTableViewCell: UITableViewCell {

  // MARK: - Constants

  private struct ViewTraits {
    // Margins
    static let contentMargin: CGFloat = 12.0
    static let postViewMargin: CGFloat = 18.0
    static let bodyTopMargin: CGFloat = 10.0

    // Fonts
    static let titleFontSize: CGFloat = 13.0
    static let bodyFontSize: CGFloat = 11.0
  }

  // MARK: - Properties

  private let postView = UIView()
  private let titleLabel = UILabel()
  private let bodyLabel = UILabel()

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

    postView.addSubviewForAutolayout(titleLabel)
    postView.addSubviewForAutolayout(bodyLabel)

    contentView.addSubviewForAutolayout(postView)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      postView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ViewTraits.postViewMargin),
      postView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ViewTraits.postViewMargin),
      postView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -ViewTraits.postViewMargin),
      postView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -ViewTraits.postViewMargin),

      titleLabel.topAnchor.constraint(equalTo: postView.topAnchor, constant: ViewTraits.contentMargin),
      titleLabel.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: ViewTraits.contentMargin),
      titleLabel.trailingAnchor.constraint(equalTo: postView.trailingAnchor, constant: -ViewTraits.contentMargin),

      bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: ViewTraits.bodyTopMargin),
      bodyLabel.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: ViewTraits.contentMargin),
      bodyLabel.trailingAnchor.constraint(equalTo: postView.trailingAnchor, constant: -ViewTraits.contentMargin),
      bodyLabel.bottomAnchor.constraint(equalTo: postView.bottomAnchor, constant: -ViewTraits.contentMargin)
    ])
  }
}
