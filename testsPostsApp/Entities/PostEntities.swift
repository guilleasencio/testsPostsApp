//
//  PostEntities.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 23/3/21.
//

import Foundation

// MARK: - Entities

struct PostEntity {
  let identifier: Int
  let userId: Int
  let title: String
  let body: String
}

// MARK: - Errors

enum GetPostsError: Error {
  case noConnection
  case responseProblems
  case badRequest
  case notFound
}
