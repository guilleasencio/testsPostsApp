//
//  PostTableViewCell.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 23/3/21.
//

import UIKit

struct PostTableViewCellData {
  let viewData: PostViewData
}

class PostTableViewCell: UITableViewCell {

  // MARK: - Constants

  private struct ViewTraits {
    // Margins
    static let postViewMargin: CGFloat = 18.0
  }

  // MARK: - Properties

  private let postView = PostView()

  // MARK: - Lifecycle

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
    postView.setupUI(data: data.viewData)
  }

  private func setupComponents() {
    backgroundColor = .clear
    selectionStyle = .none

    contentView.addSubviewForAutolayout(postView)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      postView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ViewTraits.postViewMargin),
      postView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ViewTraits.postViewMargin),
      postView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -ViewTraits.postViewMargin),
      postView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -ViewTraits.postViewMargin)
    ])
  }
}
