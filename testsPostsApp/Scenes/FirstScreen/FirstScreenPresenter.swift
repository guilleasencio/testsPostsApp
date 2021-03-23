//
//  FirstScreenPresenter.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 23/3/21.
//

import UIKit

protocol FirstScreenPresentationLogic {
  func presentSomething(response: FirstScreen.Something.Response)
}

class FirstScreenPresenter: FirstScreenPresentationLogic {
  weak var viewController: FirstScreenDisplayLogic?

  // MARK: Do something

  func presentSomething(response: FirstScreen.Something.Response) {
    let viewModel = FirstScreen.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
