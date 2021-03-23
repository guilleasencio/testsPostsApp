//
//  PostRepository.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 23/3/21.
//

import Foundation

private enum PostAPIEndpoint {
  static let getPosts = "/posts"
}

protocol PostRepositoryLogic {
  func getPosts(completion: @escaping(Result<[PostEntity], GetPostsError>) -> Void)
}

class PostRepository: PostRepositoryLogic {

  // MARK: - Public

  func getPosts(completion: @escaping(Result<[PostEntity], GetPostsError>) -> Void) {
    if let posts = getPostsFromDatabase(), !posts.isEmpty {
      completion(.success(posts))
    } else {
      let requestData = GetPostsRequestData()

      var urlComponents = URLComponents(string: NetworkConfig.baseUrl)
      urlComponents?.path = PostAPIEndpoint.getPosts
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
                                       entityType: GetPostsResponse.self,
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

  private func getPostsFromDatabase() -> [PostEntity]? {
    guard let posts = try? Managers.database.get(PostObject.self) else {
      return nil
    }
    return posts.compactMap({ $0.convertToEntity() })
  }

  private func saveData(_ entities: [PostEntity]) {
    try? Managers.database.add(entities.map({ PostObject(from: $0) }))
  }
}
