//
//  PostDataModels.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 23/3/21.
//

import Foundation

// MARK: - Request

struct GetPostsRequestData {

  func getHeaders() -> [String: String] {
    [
      "Accept": "application/json"
    ]
  }
}

// MARK: - Response

class GetPostsResponse: Decodable, DomainConvertible {
  typealias DomainEntityType = [PostEntity]

  private let posts: [PostData]

  required init(from decoder: Decoder) throws {
    posts = try [PostData](from: decoder)
  }

  func domainEntity(statusCode: Int?, headers: [String: String]) -> [PostEntity]? {
    guard !posts.isEmpty else {
      return []
    }
    return posts.compactMap({ $0.getPostEntity() })
  }

  private class PostData: Decodable {
    enum CodingKeys: String, CodingKey {
      case identifier = "id"
      case userId
      case title
      case body
    }

    private let identifier: Int
    private let userId: Int
    private let title: String
    private let body: String

    required init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)
      identifier = try values.decode(Int.self, forKey: .identifier)
      userId = try values.decode(Int.self, forKey: .userId)
      title = try values.decode(String.self, forKey: .title)
      body = try values.decode(String.self, forKey: .body)
    }

    func getPostEntity() -> PostEntity {
      PostEntity(identifier: identifier, userId: userId, title: title, body: body)
    }
  }
}
