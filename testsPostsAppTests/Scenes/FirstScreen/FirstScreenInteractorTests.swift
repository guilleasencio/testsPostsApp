//
//  FirstScreenInteractorTests.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 24/3/21.
//

import XCTest
@testable import testsPostsApp

class FirstScreenInteractorTests: XCTestCase {

  // MARK: Subject under test

  var interactor: FirstScreenInteractor?
  var presenterSpy: FirstScreenPresentationLogicSpy?
  var postRepositorySpy: PostRepositoryLogicSpy?
  var userRepositorySpy: UserRepositoryLogicSpy?
  var commentRepositorySpy: CommentRepositoryLogicSpy?

  // MARK: Test lifecycle

  override func setUp() {
    super.setUp()
    setupFirstScreenInteractor()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: Test setup

  func setupFirstScreenInteractor() {
    interactor = FirstScreenInteractor()
    presenterSpy = FirstScreenPresentationLogicSpy()
    postRepositorySpy = PostRepositoryLogicSpy()
    userRepositorySpy = UserRepositoryLogicSpy()
    commentRepositorySpy = CommentRepositoryLogicSpy()
    interactor?.presenter = presenterSpy
    interactor?.postsRepository = postRepositorySpy
    interactor?.userRepository = userRepositorySpy
    interactor?.commentRepository = commentRepositorySpy
  }

  // MARK: Test doubles

  class FirstScreenPresentationLogicSpy: FirstScreenPresentationLogic {

    var presentDataCalled = false
    var presentSelectPostCalled = false

    func presentData(response: FirstScreen.Data.Response) {
      presentDataCalled = true
    }

    func presentSelectPost(response: FirstScreen.SelectPost.Response) {
      presentSelectPostCalled = true
    }
  }

  class PostRepositoryLogicSpy: PostRepositoryLogic {

    var getPostsCalled = false
    var getPostsResponse: Result<[PostEntity], GetPostsError> = .failure(.noConnection)

    func getPosts(completion: @escaping (Result<[PostEntity], GetPostsError>) -> Void) {
      getPostsCalled = true
      completion(getPostsResponse)
    }
  }

  class UserRepositoryLogicSpy: UserRepositoryLogic {

    var getUsersCalled = false
    var getUsersResponse: Result<[UserEntity], GetUsersError> = .failure(.noConnection)

    func getUsers(completion: @escaping (Result<[UserEntity], GetUsersError>) -> Void) {
      getUsersCalled = true
      completion(getUsersResponse)
    }
  }

  class CommentRepositoryLogicSpy: CommentRepositoryLogic {

    var getCommentsCalled = false
    var getCommentsResponse: Result<[CommentEntity], GetCommentsError> = .failure(.noConnection)

    func getComments(completion: @escaping (Result<[CommentEntity], GetCommentsError>) -> Void) {
      getCommentsCalled = true
      completion(getCommentsResponse)
    }
  }

  // MARK: Tests

  func testDoLoadDataSuccess() {
    // Given
    postRepositorySpy?.getPostsResponse = .success([])
    userRepositorySpy?.getUsersResponse = .success([])
    commentRepositorySpy?.getCommentsResponse = .success([])

    // When
    interactor?.doLoadData(request: FirstScreen.Data.Request())

    // Then
    XCTAssertEqual(postRepositorySpy?.getPostsCalled, true,
                   "doLoadData() should ask the postRepository to getPosts()")
    XCTAssertEqual(userRepositorySpy?.getUsersCalled, true,
                   "doLoadData() should ask the userRepository to getUsers()")
    XCTAssertEqual(commentRepositorySpy?.getCommentsCalled, true,
                   "doLoadData() should ask the commentRepository to getComments()")
    XCTAssertEqual(presenterSpy?.presentDataCalled, true,
                   "doLoadData() should ask the presenter to presentData()")
  }

  func testDoLoadDataFailure() {
    // Given
    postRepositorySpy?.getPostsResponse = .failure(.responseProblems)
    userRepositorySpy?.getUsersResponse = .failure(.responseProblems)
    commentRepositorySpy?.getCommentsResponse = .failure(.responseProblems)

    // When
    interactor?.doLoadData(request: FirstScreen.Data.Request())

    // Then
    XCTAssertEqual(postRepositorySpy?.getPostsCalled, true,
                   "doLoadData() should ask the postRepository to getPosts()")
    XCTAssertEqual(userRepositorySpy?.getUsersCalled, true,
                   "doLoadData() should ask the userRepository to getUsers()")
    XCTAssertEqual(commentRepositorySpy?.getCommentsCalled, true,
                   "doLoadData() should ask the commentRepository to getComments()")
    XCTAssertEqual(presenterSpy?.presentDataCalled, true,
                   "doLoadData() should ask the presenter to presentData()")
  }

  // MARK: Tests

  func testDoSelectPostSuccess() {
    // Given
    postRepositorySpy?.getPostsResponse = .success([PostEntity(identifier: 1, userId: 1, title: "", body: "")])
    userRepositorySpy?.getUsersResponse = .success([UserEntity(identifier: 1, username: "")])
    let comment = CommentEntity(identifier: 1, postId: 1, name: "", email: "", body: "")
    commentRepositorySpy?.getCommentsResponse = .success([comment])
    interactor?.doLoadData(request: FirstScreen.Data.Request())

    // When
    interactor?.doSelectPost(request: FirstScreen.SelectPost.Request(index: 0))

    // Then
    XCTAssertEqual(presenterSpy?.presentSelectPostCalled, true,
                   "doSelectPost() should ask the presenter to presentSelectPost()")
  }

  func testDoSelectPostFailure() {
    // Given

    // When
    interactor?.doSelectPost(request: FirstScreen.SelectPost.Request(index: 0))

    // Then
    XCTAssertEqual(presenterSpy?.presentSelectPostCalled, false,
                   "doSelectPost() should not ask the presenter to presentSelectPost()")
  }
}
