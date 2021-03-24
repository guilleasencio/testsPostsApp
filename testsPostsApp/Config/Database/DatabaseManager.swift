//
//  DatabaseManager.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 23/3/21.
//

import Foundation
import RealmSwift

class DatabaseManager {

  // MARK: - Properties

  private var realm: Realm?

  init() {
    do {
      self.realm = try Realm()
    } catch let error as NSError {
      print(error)
    }
  }

  // MARK: - Public

  func add<Element: Object & DatabaseObjectConvertible>(_ objects: Element) throws {
    guard let realm = realm else {
      throw DatabaseError.initializationFailure
    }
    realm.beginWrite()
    realm.add(objects)
    try realm.commitWrite()
  }

  func add<Element: Object & DatabaseObjectConvertible>(_ objects: [Element]) throws {
    guard let realm = realm else {
      throw DatabaseError.initializationFailure
    }
    realm.beginWrite()
    realm.add(objects)
    try realm.commitWrite()
  }

  func get<Element: Object & DatabaseObjectConvertible>(_ objectType: Element.Type) throws -> [Element] {
    guard let realm = realm else {
      throw DatabaseError.initializationFailure
    }
    return realm.objects(objectType).map({ $0 })
  }

  func get<Element: Object & DatabaseObjectConvertible>(_ objectType: Element.Type,
                                                        filter: NSPredicate) throws -> [Element] {
    guard let realm = realm else {
      throw DatabaseError.initializationFailure
    }
    return realm.objects(objectType).filter(filter).map({ $0 })
  }

  func delete<Element: Object & DatabaseObjectConvertible>(_ objects: Element) throws {
    guard let realm = realm else {
      throw DatabaseError.initializationFailure
    }
    realm.beginWrite()
    realm.delete(objects)
    try realm.commitWrite()
  }

  func delete<Element: Object & DatabaseObjectConvertible>(_ objects: [Element]) throws {
    guard let realm = realm else {
      throw DatabaseError.initializationFailure
    }
    realm.beginWrite()
    realm.delete(objects)
    try realm.commitWrite()
  }

  func reset() throws {
    guard let realm = realm else {
      throw DatabaseError.initializationFailure
    }
    realm.beginWrite()
    realm.deleteAll()
    try realm.commitWrite()
  }
}
