//
//  PostDetailsPresenterTests.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 24/3/21.
//

import XCTest
@testable import testsPostsApp

class PostDetailsPresenterTests: XCTestCase {

  // MARK: Subject under test

  var presenter: PostDetailsPresenter?
  var viewControllerSpy: PostDetailsDisplayLogicSpy?

  // MARK: Test lifecycle

  override func setUp() {
    super.setUp()
    setupPostDetailsPresenter()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: Test setup

  func setupPostDetailsPresenter() {
    presenter = PostDetailsPresenter()
    viewControllerSpy = PostDetailsDisplayLogicSpy()
    presenter?.viewController = viewControllerSpy
  }

  // MARK: Test doubles

  class PostDetailsDisplayLogicSpy: PostDetailsDisplayLogic {

    var displayDataCalled = false

    func displayData(viewModel: PostDetails.Data.ViewModel) {
      displayDataCalled = true
    }
  }

  // MARK: Tests

  func testPresentData() {
    // Given
    let post = PostEntity(identifier: 1, userId: 1, title: "", body: "")
    let user = UserEntity(identifier: 1, username: "")
    let comment = CommentEntity(identifier: 1, postId: 1, name: "", email: "", body: "")
    let response = PostDetails.Data.Response(post: post, user: user, comments: [comment])

    // When
    presenter?.presentData(response: response)

    // Then
    XCTAssertEqual(viewControllerSpy?.displayDataCalled, true,
                   "presentData() should ask the view controller to displayData()")
  }
}
