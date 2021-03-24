//
//  CommentRepository.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 23/3/21.
//

import Foundation

private enum CommentAPIEndpoint {
  static let getComments = "/comments"
}

protocol CommentRepositoryLogic {
  func getComments(completion: @escaping(Result<[CommentEntity], GetCommentsError>) -> Void)
}

class CommentRepository: CommentRepositoryLogic {

  // MARK: - Public

  func getComments(completion: @escaping(Result<[CommentEntity], GetCommentsError>) -> Void) {
    if let comments = getCommentsFromDatabase(), !comments.isEmpty {
      completion(.success(comments))
    } else {
      let requestData = GetCommentsRequestData()

      var urlComponents = URLComponents(string: NetworkConfig.baseUrl)
      urlComponents?.path = CommentAPIEndpoint.getComments
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
                                       entityType: GetCommentsResponse.self,
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

  private func getCommentsFromDatabase() -> [CommentEntity]? {
    guard let comments = try? Managers.database.get(CommentObject.self) else {
      return nil
    }
    return comments.compactMap({ $0.convertToEntity() })
  }

  private func saveData(_ entities: [CommentEntity]) {
    try? Managers.database.add(entities.map({ CommentObject(from: $0) }))
  }
}
