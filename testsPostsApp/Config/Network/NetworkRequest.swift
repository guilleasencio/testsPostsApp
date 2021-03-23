//
//  NetworkRequest.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 22/3/21.
//

import Foundation
import Alamofire

enum HttpMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case patch = "PATCH"
  case delete = "DELETE"
  case head = "HEAD"
}

enum Encoding {
  case json
  case url

  func parameterEncoding() -> ParameterEncoding {
    switch self {
    case .json:
      return JSONEncoding.default
    case .url:
      return URLEncoding.default
    }
  }
}

struct NetworkRequest: URLRequestConvertible {

  let httpMethod: HttpMethod
  let encoding: ParameterEncoding
  let path: String
  let headers: [String: String]?
  let parameters: Parameters?

  init(httpMethod: HttpMethod,
       encoding: Encoding,
       path: String,
       headers: [String: String]? = nil,
       parameters: Parameters? = nil) {

    self.httpMethod = httpMethod
    self.encoding = encoding.parameterEncoding()
    self.path = path
    self.headers = headers
    self.parameters = parameters
  }

  func asURLRequest() throws -> URLRequest {

    guard let url = URL(string: path) else {
      throw NetworkErrorCode.badRequest.toError(withDomain: path)
    }
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = httpMethod.rawValue
    urlRequest.allHTTPHeaderFields = headers

    return try encoding.encode(urlRequest, with: parameters)
  }
}
