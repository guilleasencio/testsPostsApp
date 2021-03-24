//
//  DatabaseObjectConvertible.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 23/3/21.
//

import Foundation
import RealmSwift

protocol DatabaseObjectConvertible {
  associatedtype EntityType
  func convertToEntity() -> EntityType?
}
