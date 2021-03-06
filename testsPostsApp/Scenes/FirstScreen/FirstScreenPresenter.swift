//
//  FirstScreenPresenter.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 23/3/21.
//

import Foundation

protocol FirstScreenPresentationLogic {
  func presentData(response: FirstScreen.Data.Response)
  func presentSelectPost(response: FirstScreen.SelectPost.Response)
}

class FirstScreenPresenter: FirstScreenPresentationLogic {

  // MARK: - Properties

  weak var viewController: FirstScreenDisplayLogic?

  // MARK: Public

  func presentData(response: FirstScreen.Data.Response) {
    let state: FirstScreenViewState
    switch response.state {
    case .loading:
      state = .loading
    case .success(let posts, let users, let comments):
      state = .sucess(cellData: createTableData(posts: posts, users: users, comments: comments))
    case .error:
      state = .error
    }
    let viewModel = FirstScreen.Data.ViewModel(state: state)
    viewController?.displayData(viewModel: viewModel)
  }

  func presentSelectPost(response: FirstScreen.SelectPost.Response) {
    let viewModel = FirstScreen.SelectPost.ViewModel()
    viewController?.displaySelectPost(viewModel: viewModel)
  }

  // MARK: - Private

  private func createTableData(posts: [PostEntity],
                               users: [UserEntity],
                               comments: [CommentEntity]) -> [PostTableViewCellData] {
    posts.map({ createTableCellData(post: $0, users: users, comments: comments) })
  }

  private func createTableCellData(post: PostEntity,
                                   users: [UserEntity],
                                   comments: [CommentEntity]) -> PostTableViewCellData {
    let username = users.first(where: { $0.identifier == post.userId })?.username ?? ""
    let viewData = PostViewData(title: post.title,
                                body: post.body,
                                username: username,
                                totalComments: comments.filter({ $0.postId == post.identifier }).count,
                                hideTotalComments: false)
    return PostTableViewCellData(viewData: viewData)
  }
}
