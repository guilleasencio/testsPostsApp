//
//  UIColor.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 23/3/21.
//

import Foundation

import UIKit

extension UIColor {

  static func create(named name: String) -> UIColor {
    UIColor(named: name) ?? .black
  }
}
