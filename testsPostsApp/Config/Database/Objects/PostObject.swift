//
//  PostObject.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 23/3/21.
//

import Foundation
import RealmSwift

class PostObject: Object, DatabaseObjectConvertible {
  typealias EntityType = PostEntity

  @objc dynamic var identifier: Int = 0
  @objc dynamic var userId: Int = 0
  @objc dynamic var title: String?
  @objc dynamic var body: String?

  override init() {
    super.init()
  }

  init(from entity: EntityType) {
    self.identifier = entity.identifier
    self.userId = entity.userId
    self.title = entity.title
    self.body = entity.body
  }

  func convertToEntity() -> EntityType? {
    guard identifier > 0, userId > 0, let title = title, let body = body else {
      return nil
    }
    return EntityType(identifier: identifier, userId: userId, title: title, body: body)
  }
}
