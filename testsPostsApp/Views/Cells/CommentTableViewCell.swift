//
//  CommentTableViewCell.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 24/3/21.
//

import UIKit

struct CommentTableViewCellData {
  let viewData: CommentViewData
}

class CommentTableViewCell: UITableViewCell {

  // MARK: - Constants

  private struct ViewTraits {
    // Margins
    static let contentMargin: CGFloat = 18.0
  }

  // MARK: - Properties

  private let commentView = CommentView()

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

  func setupUI(data: CommentTableViewCellData) {
    commentView.setupUI(data: data.viewData)
  }

  private func setupComponents() {
    backgroundColor = .clear

    contentView.addSubviewForAutolayout(commentView)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      commentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ViewTraits.contentMargin / 2),
      commentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ViewTraits.contentMargin),
      commentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -ViewTraits.contentMargin),
      commentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -ViewTraits.contentMargin / 2)
    ])
  }
}
