//
//  PostDetailsRouter.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 24/3/21.
//

import UIKit

protocol PostDetailsRoutingLogic {
  func routeToParent()
}

protocol PostDetailsDataPassing {
  var dataStore: PostDetailsDataStore? { get }
}

class PostDetailsRouter: NSObject, PostDetailsRoutingLogic, PostDetailsDataPassing {

  // MARK: - Properties

  weak var viewController: PostDetailsViewController?
  var dataStore: PostDetailsDataStore?

  // MARK: Routing

  func routeToParent() {
    viewController?.navigationController?.dismiss(animated: true)
  }
}
