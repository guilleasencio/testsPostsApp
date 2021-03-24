//
//  PostDetailsViewController.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 24/3/21.
//

import UIKit

protocol PostDetailsDisplayLogic: class {
  func displayData(viewModel: PostDetails.Data.ViewModel)
}

class PostDetailsViewController: UIViewController, PostDetailsDisplayLogic {

  // MARK: - Properties

  var interactor: PostDetailsBusinessLogic?
  var router: (NSObjectProtocol & PostDetailsRoutingLogic & PostDetailsDataPassing)?

  private let sceneView = PostDetailsView()

  // MARK: Object lifecycle

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  // MARK: Setup

  private func setup() {
    let viewController = self
    let interactor = PostDetailsInteractor()
    let presenter = PostDetailsPresenter()
    let router = PostDetailsRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }

  // MARK: View lifecycle

  override func loadView() {
    view = sceneView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationBar()
    setupComponents()
    doLoadData()
  }

  // MARK: - Private

  private func setupNavigationBar() {
    navigationItem.title = "Post Details"
    navigationController?.setNavigationBarHidden(false, animated: true)

    if #available(iOS 13.0, *) {
      isModalInPresentation = true
    }

    let closeButtonView = CloseBarButtonItem()
    closeButtonView.delegate = self
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: closeButtonView)
  }

  private func setupComponents() {
//    sceneView.delegate = self
  }

  // MARK: - Output

  func doLoadData() {
    let request = PostDetails.Data.Request()
    interactor?.doLoadData(request: request)
  }

  // MARK: - Input

  func displayData(viewModel: PostDetails.Data.ViewModel) {
    sceneView.setupUI(data: viewModel.viewData)
  }
}

// MARK: - CloseBarButtonItemDelegate

extension PostDetailsViewController: CloseBarButtonItemDelegate {

  func closeBarButtonItemDidPress(_ button: CloseBarButtonItem) {
    router?.routeToParent()
  }
}
