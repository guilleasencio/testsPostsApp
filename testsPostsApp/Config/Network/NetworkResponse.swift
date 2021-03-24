//
//  NetworkResponse.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 22/3/21.
//

import Foundation

struct NetworkResponse<T> {
  let statusCode: Int?
  let headers: [String: String]
  let data: T
}
