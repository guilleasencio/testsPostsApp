//
//  PostDetailsInteractor.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 24/3/21.
//

import Foundation

protocol PostDetailsBusinessLogic {
  func doLoadData(request: PostDetails.Data.Request)
}

protocol PostDetailsDataStore {
  var post: PostEntity? { get set }
  var user: UserEntity? { get set }
  var comments: [CommentEntity] { get set }
}

class PostDetailsInteractor: PostDetailsBusinessLogic, PostDetailsDataStore {

  // MARK: - Properties

  var presenter: PostDetailsPresentationLogic?

  var post: PostEntity?
  var user: UserEntity?
  var comments: [CommentEntity] = []

  // MARK: - Public

  func doLoadData(request: PostDetails.Data.Request) {
    guard let post = post, let user = user else {
      return
    }

    let response = PostDetails.Data.Response(post: post, user: user, comments: comments)
    presenter?.presentData(response: response)
  }
}
