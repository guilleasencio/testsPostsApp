//
//  Collection.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 23/3/21.
//

import Foundation

public extension Collection {

  subscript (safe index: Index) -> Element? {
    if indices.contains(index) {
      return self[index]
    }
    return nil
  }
}
