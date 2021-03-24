//
//  SimpleTitleHeaderView.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 24/3/21.
//

import UIKit

class SimpleTitleHeaderView: UIView {

  // MARK: - Constants

  private struct ViewTraits {
    // Margins
    static let contentMargin: CGFloat = 18.0

    // Fonts
    static let titleFontSize: CGFloat = 16.0
  }

  // MARK: - Properties

  private let titleLabel = UILabel()

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

  func setupUI(text: String) {
    titleLabel.text = text
  }

  // MARK: - Private

  private func setupComponents() {
    backgroundColor = .clear

    titleLabel.lineBreakMode = .byWordWrapping
    titleLabel.numberOfLines = 0
    titleLabel.font = UIFont(name: "SF-Pro", size: ViewTraits.titleFontSize)
    titleLabel.textAlignment = .left
    titleLabel.textColor = .customBlack

    addSubviewForAutolayout(titleLabel)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: topAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ViewTraits.contentMargin),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -ViewTraits.contentMargin),
      titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -ViewTraits.contentMargin / 2)
    ])
  }
}
