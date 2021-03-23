//
//  UITableViewCell.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 23/3/21.
//

import UIKit

extension UITableViewCell {

  static var reuseIdentifier: String {
    String(describing: Self.self)
  }
}
