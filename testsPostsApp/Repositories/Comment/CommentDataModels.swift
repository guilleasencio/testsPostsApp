//
//  CommentDataModels.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 23/3/21.
//

import Foundation

// MARK: - Request

struct GetCommentsRequestData {

  func getHeaders() -> [String: String] {
    [
      "Accept": "application/json"
    ]
  }
}

// MARK: - Response

class GetCommentsResponse: Decodable, DomainConvertible {
  typealias DomainEntityType = [CommentEntity]

  private let comments: [CommentData]

  required init(from decoder: Decoder) throws {
    comments = try [CommentData](from: decoder)
  }

  func domainEntity(statusCode: Int?, headers: [String: String]) -> [CommentEntity]? {
    guard !comments.isEmpty else {
      return []
    }
    return comments.compactMap({ $0.getCommentEntity() })
  }

  private class CommentData: Decodable {
    enum CodingKeys: String, CodingKey {
      case identifier = "id"
      case postId
      case name
      case email
      case body
    }

    private let identifier: Int
    private let postId: Int
    private let name: String
    private let email: String
    private let body: String

    required init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)
      identifier = try values.decode(Int.self, forKey: .identifier)
      postId = try values.decode(Int.self, forKey: .postId)
      name = try values.decode(String.self, forKey: .name)
      email = try values.decode(String.self, forKey: .email)
      body = try values.decode(String.self, forKey: .body)
    }

    func getCommentEntity() -> CommentEntity {
      CommentEntity(identifier: identifier, postId: postId, name: name, email: email, body: body)
    }
  }
}
