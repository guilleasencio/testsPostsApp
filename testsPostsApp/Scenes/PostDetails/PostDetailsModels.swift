//
//  PostDetailsModels.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 24/3/21.
//

import Foundation

// MARK: - Use cases

enum PostDetails {
  enum Data {
    struct Request {
    }

    struct Response {
      let post: PostEntity
      let user: UserEntity
      let comments: [CommentEntity]
    }

    struct ViewModel {
      let viewData: PostDetailsViewData
    }
  }
}

// MARK: - View models

struct PostDetailsViewData {
  let headerData: PostDetailsHeaderViewData
  let cellData: [CommentTableViewCellData]
}
