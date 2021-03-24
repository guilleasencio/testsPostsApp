//
//  PostDetailsHeaderView.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 24/3/21.
//

import UIKit

struct PostDetailsHeaderViewData {
  let viewData: PostViewData
}

class PostDetailsHeaderView: UIView {

  // MARK: - Constants

  private struct ViewTraits {
    // Margins
    static let postViewMargin: CGFloat = 18.0
  }

  // MARK: - Properties

  private let postView = PostView()

  // MARK: - Lifecycle

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupComponents()
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Public

  func setupUI(data: PostDetailsHeaderViewData) {
    postView.setupUI(data: data.viewData)
  }

  private func setupComponents() {
    backgroundColor = .clear

    addSubviewForAutolayout(postView)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      postView.topAnchor.constraint(equalTo: topAnchor, constant: ViewTraits.postViewMargin),
      postView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ViewTraits.postViewMargin),
      postView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -ViewTraits.postViewMargin),
      postView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -ViewTraits.postViewMargin)
    ])
  }
}
