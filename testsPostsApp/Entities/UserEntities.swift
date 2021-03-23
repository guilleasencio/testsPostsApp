//
//  UserEntities.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 23/3/21.
//

import Foundation

// MARK: - Entities

struct UserEntity {
  let identifier: Int
  let username: String
}

// MARK: - Errors

enum GetUsersError: Error {
  case noConnection
  case responseProblems
  case badRequest
  case notFound
}
