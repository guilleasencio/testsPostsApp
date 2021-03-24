//
//  CommentObject.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 23/3/21.
//

import Foundation
import RealmSwift

class CommentObject: Object, DatabaseObjectConvertible {
  typealias EntityType = CommentEntity

  @objc dynamic var identifier: Int = 0
  @objc dynamic var postId: Int = 0
  @objc dynamic var name: String?
  @objc dynamic var email: String?
  @objc dynamic var body: String?

  override init() {
    super.init()
  }

  init(from entity: EntityType) {
    self.identifier = entity.identifier
    self.postId = entity.postId
    self.name = entity.name
    self.email = entity.email
    self.body = entity.body
  }

  func convertToEntity() -> EntityType? {
    guard identifier > 0, postId > 0, let name = name, let email = email, let body = body else {
      return nil
    }
    return EntityType(identifier: identifier, postId: postId, name: name, email: email, body: body)
  }
}
