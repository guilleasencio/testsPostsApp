//
//  PostDetailsPresenter.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 24/3/21.
//

import Foundation

protocol PostDetailsPresentationLogic {
  func presentData(response: PostDetails.Data.Response)
}

class PostDetailsPresenter: PostDetailsPresentationLogic {

  // MARK: - Properties

  weak var viewController: PostDetailsDisplayLogic?

  // MARK: - Public

  func presentData(response: PostDetails.Data.Response) {
    let viewData = createPostDetailsViewData(post: response.post, user: response.user, comments: response.comments)
    let viewModel = PostDetails.Data.ViewModel(viewData: viewData)
    viewController?.displayData(viewModel: viewModel)
  }

  // MARK: - Private

  private func createPostDetailsViewData(post: PostEntity,
                                         user: UserEntity,
                                         comments: [CommentEntity]) -> PostDetailsViewData {
    let viewData = PostViewData(title: post.title,
                                body: post.body,
                                username: user.username,
                                totalComments: comments.count,
                                hideTotalComments: true)
    return PostDetailsViewData(headerData: PostDetailsHeaderViewData(viewData: viewData),
                               cellData: comments.map({ createCommentTableViewCellData(comment: $0) }))
  }

  private func createCommentTableViewCellData(comment: CommentEntity) -> CommentTableViewCellData {
    let viewData = CommentViewData(email: comment.email, title: comment.name, body: comment.body)
    return CommentTableViewCellData(viewData: viewData)
  }
}
