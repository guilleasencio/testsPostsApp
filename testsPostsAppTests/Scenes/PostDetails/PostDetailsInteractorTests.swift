//
//  PostDetailsInteractorTests.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 24/3/21.
//

import XCTest
@testable import testsPostsApp

class PostDetailsInteractorTests: XCTestCase {

  // MARK: Subject under test

  var interactor: PostDetailsInteractor?
  var presenterSpy: PostDetailsPresentationLogicSpy?

  // MARK: Test lifecycle

  override func setUp() {
    super.setUp()
    setupPostDetailsInteractor()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: Test setup

  func setupPostDetailsInteractor() {
    interactor = PostDetailsInteractor()
    presenterSpy = PostDetailsPresentationLogicSpy()
    interactor?.presenter = presenterSpy
  }

  // MARK: Test doubles

  class PostDetailsPresentationLogicSpy: PostDetailsPresentationLogic {

    var presentDataCalled = false

    func presentData(response: PostDetails.Data.Response) {
      presentDataCalled = true
    }
  }

  // MARK: Tests

  func testDoLodaDataSuccess() {
    // Given
    interactor?.post = PostEntity(identifier: 1, userId: 1, title: "", body: "")
    interactor?.user = UserEntity(identifier: 1, username: "")
    interactor?.comments = [CommentEntity(identifier: 1, postId: 1, name: "", email: "", body: "")]

    // When
    interactor?.doLoadData(request: PostDetails.Data.Request())

    // Then
    XCTAssertEqual(presenterSpy?.presentDataCalled, true, "doLoadData() should ask the presenter to presentData()")
  }

  func testDoLodaDataFailure() {
    // Given

    // When
    interactor?.doLoadData(request: PostDetails.Data.Request())

    // Then
    XCTAssertEqual(presenterSpy?.presentDataCalled, false,
                   "doLoadData() should ask not the presenter to presentData()")
  }
}
