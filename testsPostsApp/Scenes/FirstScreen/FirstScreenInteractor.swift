//
//  FirstScreenInteractor.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 23/3/21.
//

import UIKit

protocol FirstScreenBusinessLogic {
  func doSomething(request: FirstScreen.Something.Request)
}

protocol FirstScreenDataStore {
  // var name: String { get set }
}

class FirstScreenInteractor: FirstScreenBusinessLogic, FirstScreenDataStore {
  var presenter: FirstScreenPresentationLogic?
  // var name: String = ""

  // MARK: Do something

  func doSomething(request: FirstScreen.Something.Request) {

    let response = FirstScreen.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
