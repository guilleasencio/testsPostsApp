//
//  UserObject.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 23/3/21.
//

import Foundation
import RealmSwift

class UserObject: Object, DatabaseObjectConvertible {
  typealias EntityType = UserEntity

  @objc dynamic var identifier: Int = 0
  @objc dynamic var username: String?

  override init() {
    super.init()
  }

  init(from entity: EntityType) {
    self.identifier = entity.identifier
    self.username = entity.username
  }

  func convertToEntity() -> EntityType? {
    guard identifier > 0, let username = username else {
      return nil
    }
    return EntityType(identifier: identifier, username: username)
  }
}
