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

extension NetworkManager: PostRepositoryLogic {

  // MARK: - Public

  func getPosts(completion: @escaping(Result<[PostEntity], GetPostsError>) -> Void) {
    let requestData = GetPostsRequestData()

    var urlComponents = URLComponents(string: NetworkConfig.baseUrl)
    urlComponents?.path = PostAPIEndpoint.getPosts
    let path = urlComponents?.url?.absoluteString ?? ""
    let networkRequest = NetworkRequest(httpMethod: .get,
                                        encoding: .json,
                                        path: path,
                                        headers: requestData.getHeaders())
    request(networkRequest) { networkResult in
      switch networkResult {
      case .success(let response):
        let parser = NetworkEntityParser()
        if let entity = parser.parse(data: response.data,
                                     entityType: GetPostsResponse.self,
                                     statusCode: response.statusCode,
                                     headers: response.headers) {
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
