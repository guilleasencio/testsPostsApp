//
//  CommentEntities.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 23/3/21.
//

import Foundation

// MARK: - Entities

struct CommentEntity {
  let identifier: Int
  let postId: Int
  let name: String
  let email: String
  let body: String
}

// MARK: - Errors

enum GetCommentsError: Error {
  case noConnection
  case responseProblems
  case badRequest
  case notFound
}
