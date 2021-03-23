//
//  FirstScreenRouter.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 23/3/21.
//

import UIKit

@objc protocol FirstScreenRoutingLogic {
  // func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol FirstScreenDataPassing {
  var dataStore: FirstScreenDataStore? { get }
}

class FirstScreenRouter: NSObject, FirstScreenRoutingLogic, FirstScreenDataPassing {
  weak var viewController: FirstScreenViewController?
  var dataStore: FirstScreenDataStore?

  // MARK: Routing

}
