//
//  NetworkManager.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 22/3/21.
//

import Foundation
import Alamofire

private struct Timeout {
  static let secondsForRequest = 15.0 // secs
  static let secondsForResource = 15.0 // secs
}

private struct StatusCode {
  static let valid = 200..<305 // acceptable status code range
}

class NetworkManager: Session {

  // MARK: - Properties

  let reachabilityManager: NetworkReachabilityManager?
  var isReachable: Bool { reachabilityManager?.isReachable == true }

  init() {
    // set reachability manager
    reachabilityManager = NetworkReachabilityManager()

    // session configuration
    let sessionConfig = URLSessionConfiguration.af.default
    sessionConfig.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    sessionConfig.headers = .default
    sessionConfig.timeoutIntervalForRequest = Timeout.secondsForRequest
    sessionConfig.timeoutIntervalForResource = Timeout.secondsForResource

    // root queue
    let rootQueue = DispatchQueue(label: "org.alamofire.session.rootQueue")
    let delegateQueue = OperationQueue()
    delegateQueue.qualityOfService = .default
    delegateQueue.maxConcurrentOperationCount = 1
    delegateQueue.underlyingQueue = rootQueue
    delegateQueue.name = "org.alamofire.session.sessionDelegateQueue"
    delegateQueue.isSuspended = false

    let delegate = SessionDelegate()

    let session = URLSession(configuration: sessionConfig,
                             delegate: delegate,
                             delegateQueue: delegateQueue)

    super.init(session: session,
               delegate: delegate,
               rootQueue: rootQueue)
  }

  // MARK: - Public

  func request(
    _ request: NetworkRequest,
    completionHandler: @escaping (Swift.Result<NetworkResponse<Data>, NetworkError<EmptyDecodable>>) -> Void) {
    logRequest(request)
    if !isReachable {
      completionHandler(.failure(.init(code: .noConnection, response: nil)))
    } else {
      super.request(request).validate(logResponse).validate(statusCode: StatusCode.valid).responseData { (response) in
        self.handleResponse(response, completion: completionHandler)
      }
    }
  }

  func request<ErrorType: Decodable>(
    _ request: NetworkRequest,
    errorType: ErrorType.Type,
    completionHandler: @escaping (Swift.Result<NetworkResponse<Data>, NetworkError<ErrorType>>) -> Void) {

    logRequest(request)
    if !isReachable {
      completionHandler(.failure(.init(code: .noConnection, response: nil)))
    } else {
      super.request(request).validate(logResponse).validate(statusCode: StatusCode.valid).responseData { (response) in
        self.handleResponse(response, completion: completionHandler)
      }
    }
  }

  // MARK: - Private

  private let logResponse: DataRequest.Validation = { (request, response, data) in
    let statusCode = response.statusCode
    let reqUrlStr = request?.url?.absoluteString ?? ""
    #if DEBUG
    if let data = data, let dataString = String(data: data, encoding: .utf8) {
      print("\(reqUrlStr) -->statusCode: \(statusCode)\n\(dataString)")
    } else {
      print("\(reqUrlStr) -->statusCode: \(statusCode)\nNo data")
    }
    #endif
    return .success(())
  }

  private func logRequest(_ request: NetworkRequest) {
    if let urlRequest = try? request.asURLRequest(),
       let urlString = urlRequest.url?.absoluteString {
      logRequest(httpMethod: request.httpMethod,
                 urlString,
                 parameters: request.parameters,
                 httpBody: urlRequest.httpBody,
                 headers: urlRequest.allHTTPHeaderFields)
    }
  }

  private func logRequest(httpMethod: HttpMethod, _ URLString: URLConvertible, parameters: [String: Any]?,
                          httpBody: Data? = nil, headers: [String: String]?) {
    var logs = ["\(httpMethod) \(URLString)"]

    if let headers = headers, !headers.isEmpty {
      if let jsonData = try? JSONSerialization.data(withJSONObject: headers, options: .prettyPrinted),
         let jsonStr = String(data: jsonData, encoding: .utf8) {
        logs += ["headers:"]
        logs += jsonStr.components(separatedBy: "\n")
      }
    }

    if let parameters = parameters, !parameters.isEmpty {
      if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted),
         let jsonStr = String(data: jsonData, encoding: .utf8) {
        logs += ["params:"]
        logs += jsonStr.components(separatedBy: "\n")
      }
    }

    if let body = httpBody {
      if let jsonStr = String(data: body, encoding: .utf8) {
        logs += ["body:"]
        logs += jsonStr.components(separatedBy: "\n")
      }
    }

    #if DEBUG
    let logsStr = logs.map({ String(describing: $0) }).joined(separator: ",")
    print("request: \n\(logsStr)")
    #endif
  }

  private func handleResponse<ErrorType: Decodable>(
    _ response: AFDataResponse<Data>,
    completion: @escaping (Swift.Result<NetworkResponse<Data>, NetworkError<ErrorType>>) -> Void) {

    let statusCode = response.response?.statusCode
    let headers = adaptHeaders(response.response?.allHeaderFields ?? [:])
    let data = response.data ?? Data()
    switch response.result {
    case .success:
      let networkResponse = NetworkResponse(statusCode: statusCode, headers: headers, data: data)
      completion(.success(networkResponse))
    case .failure:
      if statusCode == NSURLErrorNotConnectedToInternet {
        let networkError = NetworkError<ErrorType>(code: NetworkErrorCode.noConnection, response: nil)
        completion(.failure(networkError))
      } else if let errorModel = NetworkEntityParser().parse(data: data, entityType: ErrorType.self) {
        let networkResponse = NetworkResponse(statusCode: statusCode, headers: headers, data: errorModel)
        let networkError = NetworkError(code: NetworkErrorCode.from(code: statusCode), response: networkResponse)
        completion(.failure(networkError))
      } else {
        let networkError = NetworkError<ErrorType>(code: NetworkErrorCode.unableToParseResponse, response: nil)
        completion(.failure(networkError))
      }
    }
  }

  private func adaptHeaders(_ headers: [AnyHashable: Any]) -> [String: String] {
    var adaptedHeaders: [String: String] = [:]
    for (key, value) in headers {
      guard let keyString = key as? String, let valueString = value as? String else {
        continue
      }
      adaptedHeaders[keyString] = valueString
    }
    return adaptedHeaders
  }
}
