//
//  LoaderView.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 23/3/21.
//

import UIKit

class LoaderView: UIView {

  // MARK: - Constants

  private struct ViewTraits {
    // Size
    static let imageSize: CGFloat = 50.0
  }

  // MARK: - Properties

  private let activityIndicatorImageView = UIImageView()

  // MARK: - View's Lifecycle

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupComponents()
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Public

  func startAnimating() {
    let rotationAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.transform))
    rotationAnimation.valueFunction = CAValueFunction(name: CAValueFunctionName.rotateZ)
    rotationAnimation.fromValue = 0
    rotationAnimation.toValue = -CGFloat(Double.pi * 2)
    rotationAnimation.isRemovedOnCompletion = false
    rotationAnimation.duration = 1
    rotationAnimation.repeatCount = .infinity
    activityIndicatorImageView.layer.add(rotationAnimation, forKey: nil)
    activityIndicatorImageView.isHidden = false
  }

  func stopAnimating() {
    if let transform = activityIndicatorImageView.layer.presentation()?.transform {
      activityIndicatorImageView.layer.transform = transform
    }
    activityIndicatorImageView.layer.removeAllAnimations()
    activityIndicatorImageView.isHidden = true
  }

  // MARK: - Private

  private func setupComponents() {
    activityIndicatorImageView.image = UIImage(named: "loader")
    activityIndicatorImageView.contentMode = .scaleAspectFit
    addSubviewForAutolayout(activityIndicatorImageView)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      activityIndicatorImageView.heightAnchor.constraint(equalToConstant: ViewTraits.imageSize),
      activityIndicatorImageView.widthAnchor.constraint(equalToConstant: ViewTraits.imageSize),
      activityIndicatorImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
      activityIndicatorImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }
}
