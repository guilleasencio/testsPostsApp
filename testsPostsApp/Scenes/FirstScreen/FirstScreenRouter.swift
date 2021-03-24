//
//  FirstScreenRouter.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 23/3/21.
//

import UIKit

@objc protocol FirstScreenRoutingLogic {
  func routeToPostDetails()
}

protocol FirstScreenDataPassing {
  var dataStore: FirstScreenDataStore? { get }
}

class FirstScreenRouter: NSObject, FirstScreenRoutingLogic, FirstScreenDataPassing {

  // MARK: - Properties

  weak var viewController: FirstScreenViewController?
  var dataStore: FirstScreenDataStore?

  // MARK: Routing

  func routeToPostDetails() {
    let destinationVC = PostDetailsViewController()
    if let sourceDS = dataStore, var destinationDS = destinationVC.router?.dataStore {
      destinationDS.post = sourceDS.selectedPost
      destinationDS.user = sourceDS.selectedPostUser
      destinationDS.comments = sourceDS.selectedPostComments
    }
    let navigationViewController: UINavigationController = UINavigationController(rootViewController: destinationVC)
    viewController?.present(navigationViewController, animated: true, completion: nil)
  }
}
