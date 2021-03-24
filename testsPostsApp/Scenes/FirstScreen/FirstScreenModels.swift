//
//  FirstScreenModels.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 23/3/21.
//

import UIKit

enum FirstScreen {
  // MARK: Use cases

  enum Data {
    struct Request {
    }

    struct Response {
      let state: FirstScreenState
    }

    struct ViewModel {
      let state: FirstScreenViewState
    }
  }

  enum SelectPost {
    struct Request {
      let index: Int
    }

    struct Response {
    }

    struct ViewModel {
    }
  }
}

// MARK: - Business models

enum FirstScreenState {
  case loading
  case success(posts: [PostEntity], users: [UserEntity], comments: [CommentEntity])
  case error
}

// MARK: - View models

enum FirstScreenViewState {
  case loading
  case sucess(cellData: [PostTableViewCellData])
  case error
}
