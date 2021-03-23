//
//  FirstScreenPresenter.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 23/3/21.
//

import UIKit

protocol FirstScreenPresentationLogic {
  func presentData(response: FirstScreen.Data.Response)
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
    case .posts(let data):
      state = .sucess(cellData: createTableData(data: data))
    case .error:
      state = .error
    }
    let viewModel = FirstScreen.Data.ViewModel(state: state)
    viewController?.displayData(viewModel: viewModel)
  }

  private func createTableData(data: [PostEntity]) -> [PostTableViewCellData] {
    data.map({ createTableCellData(data: $0) })
  }

  private func createTableCellData(data: PostEntity) -> PostTableViewCellData {
    PostTableViewCellData(title: data.title, body: data.body)
  }
}
