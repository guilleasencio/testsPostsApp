//
//  UserDataModels.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 23/3/21.
//

import Foundation

// MARK: - Request

struct GetUsersRequestData {

  func getHeaders() -> [String: String] {
    [
      "Accept": "application/json"
    ]
  }
}

// MARK: - Response

class GetUsersResponse: Decodable, DomainConvertible {
  typealias DomainEntityType = [UserEntity]

  private let users: [UserData]

  required init(from decoder: Decoder) throws {
    users = try [UserData](from: decoder)
  }

  func domainEntity(statusCode: Int?, headers: [String: String]) -> [UserEntity]? {
    guard !users.isEmpty else {
      return []
    }
    return users.compactMap({ $0.getUserEntity() })
  }

  private class UserData: Decodable {
    enum CodingKeys: String, CodingKey {
      case identifier = "id"
      case username
    }

    private let identifier: Int
    private let username: String

    required init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)
      identifier = try values.decode(Int.self, forKey: .identifier)
      username = try values.decode(String.self, forKey: .username)
    }

    func getUserEntity() -> UserEntity {
      UserEntity(identifier: identifier, username: username)
    }
  }
}
