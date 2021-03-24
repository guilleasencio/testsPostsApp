//
//  FirstScreenPresenterTests.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 24/3/21.
//

import XCTest
@testable import testsPostsApp

class FirstScreenPresenterTests: XCTestCase {

  // MARK: Subject under test

  var presenter: FirstScreenPresenter?
  var viewControllerSpy: FirstScreenDisplayLogicSpy?

  // MARK: Test lifecycle

  override func setUp() {
    super.setUp()
    setupFirstScreenPresenter()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: Test setup

  func setupFirstScreenPresenter() {
    presenter = FirstScreenPresenter()
    viewControllerSpy = FirstScreenDisplayLogicSpy()
    presenter?.viewController = viewControllerSpy
  }

  // MARK: Test doubles

  class FirstScreenDisplayLogicSpy: FirstScreenDisplayLogic {

    var displayDataCalled = false
    var displaySelectPostCalled = false

    func displayData(viewModel: FirstScreen.Data.ViewModel) {
      displayDataCalled = true
    }

    func displaySelectPost(viewModel: FirstScreen.SelectPost.ViewModel) {
      displaySelectPostCalled = true
    }
  }

  // MARK: Tests

  func testPresentDataLoading() {
    // Given

    // When
    presenter?.presentData(response: FirstScreen.Data.Response(state: .loading))

    // Then
    XCTAssertEqual(viewControllerSpy?.displayDataCalled, true,
                   "presentData() should ask the view controller to displayData()")
  }

  func testPresentDataSuccess() {
    // Given
    let post = PostEntity(identifier: 1, userId: 1, title: "", body: "")
    let user = UserEntity(identifier: 1, username: "")
    let comment = CommentEntity(identifier: 1, postId: 1, name: "", email: "", body: "")
    let response = FirstScreen.Data.Response(state: .success(posts: [post], users: [user], comments: [comment]))

    // When
    presenter?.presentData(response: response)

    // Then
    XCTAssertEqual(viewControllerSpy?.displayDataCalled, true,
                   "presentData() should ask the view controller to displayData()")
  }

  func testPresentDataFailure() {
    // Given

    // When
    presenter?.presentData(response: FirstScreen.Data.Response(state: .error))

    // Then
    XCTAssertEqual(viewControllerSpy?.displayDataCalled, true,
                   "presentData() should ask the view controller to displayData()")
  }

  func testPresentSelectPost() {
    // Given

    // When
    presenter?.presentSelectPost(response: FirstScreen.SelectPost.Response())

    // Then
    XCTAssertEqual(viewControllerSpy?.displaySelectPostCalled, true,
                   "presentSelectPost() should ask the view controller to displaySelectPost()")
  }
}
