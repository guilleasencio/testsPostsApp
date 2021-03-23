//
//  NetworkError.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 22/3/21.
//

import Foundation

// https://httpstatuses.com/
enum NetworkErrorCode: Int {
  case noConnection = -1 // custom code for connection problems
  case unableToCreateUrl = -2
  case unableToParseResponse = -3
  case badRequest = 400
  case unauthorized = 401
  case paymentRequired = 402
  case forbidden = 403
  case notFound = 404
  case methodNotAllowed = 405
  case notAcceptable = 406
  case proxyAuthenticationRequired = 407
  case requestTimeout = 408
  case conflict = 409
  case gone = 410
  case lengthRequired = 411
  case preconditionFailed = 412
  case payloadTooLarge = 413
  case requestURITooLong = 414
  case unsupportedMediaType = 415
  case requestedRangeNotSatisfiable = 416
  case expectationFailed = 417
  case imATeapot = 418
  case misdirectedRequest = 421
  case unprocessableEntity = 422
  case locked = 423
  case failedDependency = 424
  case upgradeRequired = 426
  case preconditionRequired = 428
  case tooManyRequests = 429
  case requestHeaderFieldsTooLarge = 431
  case connectionClosedWithoutResponse = 444
  case unavailableForLegalReasons = 451
  case clientClosedRequest = 499
  case internalServerError = 500
  case notImplemented = 501
  case badGateway = 502
  case serviceUnavailable = 503
  case gatewayTimeout = 504
  case httpVersionNotSupported = 505
  case variantAlsoNegotiates = 506
  case insufficientStorage = 507
  case loopDetected = 508
  case notExtended = 510
  case networkAuthenticationRequired = 511
  case networkConnectTimeoutError = 599

  static func from(code: Int?) -> NetworkErrorCode {
    if let code = code, let error = NetworkErrorCode(rawValue: code) {
      return error
    }
    return .badRequest
  }

  static func from(error: Error) -> NetworkErrorCode {
    NetworkErrorCode(rawValue: (error as NSError).code) ?? .badRequest
  }

  func toError(withDomain domain: String) -> Error {
    NSError(domain: domain, code: rawValue)
  }
}

struct NetworkError<T: Decodable>: Error {
  let code: NetworkErrorCode
  let response: NetworkResponse<T>?
}

struct EmptyDecodable: Decodable {
}
