//
//  Repositories.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 23/3/21.
//

import Foundation

class Repositories {

  // MARK: - Properties

  static let comments = CommentRepository()
  static let posts = PostRepository()
  static let users = UserRepository()
}
