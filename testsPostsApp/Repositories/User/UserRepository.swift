//
//  UserRepository.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 23/3/21.
//

import Foundation

private enum UserAPIEndpoint {
  static let getUsers = "/users"
}

protocol UserRepositoryLogic {
  func getUsers(completion: @escaping(Result<[UserEntity], GetUsersError>) -> Void)
}

class UserRepository: UserRepositoryLogic {

  // MARK: - Public

  func getUsers(completion: @escaping(Result<[UserEntity], GetUsersError>) -> Void) {
    if let users = getUsersFromDatabase(), !users.isEmpty {
      completion(.success(users))
    } else {
      let requestData = GetUsersRequestData()

      var urlComponents = URLComponents(string: NetworkConfig.baseUrl)
      urlComponents?.path = UserAPIEndpoint.getUsers
      let path = urlComponents?.url?.absoluteString ?? ""
      let networkRequest = NetworkRequest(httpMethod: .get,
                                          encoding: .json,
                                          path: path,
                                          headers: requestData.getHeaders())
      Managers.network.request(networkRequest) { networkResult in
        switch networkResult {
        case .success(let response):
          let parser = NetworkEntityParser()
          if let entity = parser.parse(data: response.data,
                                       entityType: GetUsersResponse.self,
                                       statusCode: response.statusCode,
                                       headers: response.headers) {
            self.saveData(entity)
            completion(.success(entity))
          } else {
            completion(.failure(.responseProblems))
          }
        case .failure(let error):
          switch error.code {
          case .noConnection:
            completion(.failure(.noConnection))
          case .badRequest:
            completion(.failure(.badRequest))
          case .notFound:
            completion(.failure(.notFound))
          default:
            completion(.failure(.responseProblems))
          }
        }
      }
    }
  }

  // MARK: - Private

  private func getUsersFromDatabase() -> [UserEntity]? {
    guard let users = try? Managers.database.get(UserObject.self) else {
      return nil
    }
    return users.compactMap({ $0.convertToEntity() })
  }

  private func saveData(_ entities: [UserEntity]) {
    try? Managers.database.add(entities.map({ UserObject(from: $0) }))
  }
}
