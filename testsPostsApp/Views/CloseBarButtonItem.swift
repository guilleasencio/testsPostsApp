//
//  CloseBarButtonItem.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 24/3/21.
//

import UIKit

protocol CloseBarButtonItemDelegate: class {
  func closeBarButtonItemDidPress(_ button: CloseBarButtonItem)
}

class CloseBarButtonItem: UIView {

  // MARK: - Constants

  private struct ViewTraits {
    // Sizes
    static let buttonSize: CGFloat = 16.0
  }

  // MARK: - Properties

  weak var delegate: CloseBarButtonItemDelegate?

  private let closeButtonView = UIButton()

  // MARK: - Lifecycle

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupComponents()
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Actions

  @objc private func didTapCloseButton() {
    delegate?.closeBarButtonItemDidPress(self)
  }

  // MARK: - Private

  private func setupComponents() {
    closeButtonView.setImage(UIImage(named: "close_icon"), for: .normal)
    closeButtonView.imageView?.contentMode = .scaleAspectFit
    closeButtonView.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)

    addSubviewForAutolayout(closeButtonView)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      closeButtonView.heightAnchor.constraint(equalToConstant: ViewTraits.buttonSize),
      closeButtonView.widthAnchor.constraint(equalToConstant: ViewTraits.buttonSize),
      closeButtonView.leadingAnchor.constraint(equalTo: leadingAnchor),
      closeButtonView.trailingAnchor.constraint(equalTo: trailingAnchor),
      closeButtonView.topAnchor.constraint(equalTo: topAnchor),
      closeButtonView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}
