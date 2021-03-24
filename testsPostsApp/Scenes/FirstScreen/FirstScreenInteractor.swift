//
//  FirstScreenInteractor.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 23/3/21.
//

import Foundation

protocol FirstScreenBusinessLogic {
  func doLoadData(request: FirstScreen.Data.Request)
  func doSelectPost(request: FirstScreen.SelectPost.Request)
}

protocol FirstScreenDataStore {
  var selectedPost: PostEntity? { get }
  var selectedPostUser: UserEntity? { get }
  var selectedPostComments: [CommentEntity] { get }
}

class FirstScreenInteractor: FirstScreenBusinessLogic, FirstScreenDataStore {

  // MARK: - Properties

  var presenter: FirstScreenPresentationLogic?
  var postsRepository: PostRepositoryLogic?
  var userRepository: UserRepositoryLogic?
  var commentRepository: CommentRepositoryLogic?

  private(set) var selectedPost: PostEntity?
  private(set) var selectedPostUser: UserEntity?
  private(set) var selectedPostComments: [CommentEntity] = []

  private let group = DispatchGroup()

  private var posts: [PostEntity] = []
  private var users: [UserEntity] = []
  private var comments: [CommentEntity] = []

  private var error: Error?

  // MARK: Public

  func doLoadData(request: FirstScreen.Data.Request) {

    let response = FirstScreen.Data.Response(state: .loading)
    presenter?.presentData(response: response)

    // Request data and store in the internal database
    getPosts()
    getUsers()
    getComments()

    group.notify(queue: .main) {
      if self.error != nil {
        let response = FirstScreen.Data.Response(state: .error)
        self.presenter?.presentData(response: response)
      } else {
        let state: FirstScreenState = .success(posts: self.posts, users: self.users, comments: self.comments)
        let response = FirstScreen.Data.Response(state: state)
        self.presenter?.presentData(response: response)
      }
    }
  }

  func doSelectPost(request: FirstScreen.SelectPost.Request) {
    guard let post = posts[safe: request.index] else {
      return
    }

    self.selectedPost = post
    self.selectedPostUser = users.first(where: { $0.identifier == post.userId })
    self.selectedPostComments = comments.filter({ $0.postId == post.identifier })

    let response = FirstScreen.SelectPost.Response()
    self.presenter?.presentSelectPost(response: response)
  }

  // MARK: - Private

  private func getPosts() {
    guard let postsRepository = postsRepository else {
      return
    }
    group.enter()
    postsRepository.getPosts { [weak self] result in
      guard let self = self else {
        return
      }
      switch result {
      case .success(let entities):
        self.posts = entities
      case .failure(let error):
        self.error = error
      }
      self.group.leave()
    }
  }

  private func getUsers() {
    guard let userRepository = userRepository else {
      return
    }
    group.enter()
    userRepository.getUsers { [weak self] result in
      guard let self = self else {
        return
      }
      switch result {
      case .success(let entities):
        self.users = entities
      case .failure(let error):
        self.error = error
      }
      self.group.leave()
    }
  }

  private func getComments() {
    guard let commentRepository = commentRepository else {
      return
    }
    group.enter()
    commentRepository.getComments { [weak self] result in
      guard let self = self else {
        return
      }
      switch result {
      case .success(let entities):
        self.comments = entities
      case .failure(let error):
        self.error = error
      }
      self.group.leave()
    }
  }
}
