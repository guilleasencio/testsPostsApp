//
//  FirstScreenInteractor.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 23/3/21.
//

import UIKit

protocol FirstScreenBusinessLogic {
  func doLoadData(request: FirstScreen.Data.Request)
}

protocol FirstScreenDataStore {
  // var name: String { get set }
}

class FirstScreenInteractor: FirstScreenBusinessLogic, FirstScreenDataStore {

  // MARK: - Properties

  var presenter: FirstScreenPresentationLogic?
  var postsRepository: PostRepositoryLogic?

  private var posts: [PostEntity] = []

  // MARK: Public

  func doLoadData(request: FirstScreen.Data.Request) {
    guard let postsRepository = postsRepository else {
      return
    }

    let response = FirstScreen.Data.Response(state: .loading)
    presenter?.presentData(response: response)

    postsRepository.getPosts { [weak self] result in
      guard let self = self else {
        return
      }
      let state: FirstScreenState
      switch result {
      case .success(let entities):
        self.posts = entities
        state = .posts(data: entities)
      case .failure:
        state = .error
      }
      let response = FirstScreen.Data.Response(state: state)
      self.presenter?.presentData(response: response)
    }
  }
}
