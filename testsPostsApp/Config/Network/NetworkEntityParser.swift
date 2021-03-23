//
//  NetworkEntityParser.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 22/3/21.
//

import Foundation

protocol DomainConvertible {
  associatedtype DomainEntityType
  func domainEntity(statusCode: Int?, headers: [String: String]) -> DomainEntityType?
}

struct NetworkEntityParser {

  func parse<MyDecodable: Decodable>(data: Data, entityType: MyDecodable.Type) -> MyDecodable? {
    let decoder = JSONDecoder()
    var returnValue: MyDecodable?
    do {
      let data = (data.isEmpty) ? try JSONSerialization.data(withJSONObject: [:]) : data
      returnValue = try decoder.decode(entityType, from: data)
    } catch {
      if let derror = error as? DecodingError {
        #if DEBUG
        print("**********************************************************")
        print(derror.localizedDescription)
        print("\(derror)")
        print("**********************************************************")
        #endif
      }
    }
    return returnValue
  }

  func parse<MyDecodable: Decodable & DomainConvertible>(data: Data,
                                                         entityType: MyDecodable.Type,
                                                         statusCode: Int?,
                                                         headers: [String: String]) -> MyDecodable.DomainEntityType? {
    let entity = parse(data: data, entityType: entityType)
    return entity?.domainEntity(statusCode: statusCode, headers: headers)
  }

  func parse<MyDecodable: Decodable & DomainConvertible>(data: Data,
                                                         entityType: [MyDecodable].Type,
                                                         statusCode: Int?,
                                                         headers: [String: String]) -> [MyDecodable.DomainEntityType]? {
    let entities = parse(data: data, entityType: entityType)
    return entities?.compactMap { $0.domainEntity(statusCode: statusCode, headers: headers) }
  }
}
