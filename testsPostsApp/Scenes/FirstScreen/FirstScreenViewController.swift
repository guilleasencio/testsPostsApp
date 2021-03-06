//
//  FirstScreenViewController.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 23/3/21.
//

import UIKit

protocol FirstScreenDisplayLogic: class {
  func displayData(viewModel: FirstScreen.Data.ViewModel)
  func displaySelectPost(viewModel: FirstScreen.SelectPost.ViewModel)
}

class FirstScreenViewController: UIViewController, FirstScreenDisplayLogic {

  // MARK: - Properties

  var interactor: FirstScreenBusinessLogic?
  var router: (NSObjectProtocol & FirstScreenRoutingLogic & FirstScreenDataPassing)?

  private let sceneView = FirstScreenView()

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
    let interactor = FirstScreenInteractor()
    let presenter = FirstScreenPresenter()
    let router = FirstScreenRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    interactor.postsRepository = Repositories.posts
    interactor.userRepository = Repositories.users
    interactor.commentRepository = Repositories.comments
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
    navigationController?.setNavigationBarHidden(false, animated: false)
    navigationItem.title = "Post list"
  }

  private func setupComponents() {
    sceneView.delegate = self
  }

  // MARK: - Output

  func doLoadData() {
    let request = FirstScreen.Data.Request()
    interactor?.doLoadData(request: request)
  }

  func doSelectPost(index: Int) {
    let request = FirstScreen.SelectPost.Request(index: index)
    interactor?.doSelectPost(request: request)
  }

  // MARK: - Input

  func displayData(viewModel: FirstScreen.Data.ViewModel) {
    sceneView.setState(state: viewModel.state)
  }

  func displaySelectPost(viewModel: FirstScreen.SelectPost.ViewModel) {
    router?.routeToPostDetails()
  }
}

// MARK: - FirstScreenViewDelegate

extension FirstScreenViewController: FirstScreenViewDelegate {

  func firstScreenViewDidTapCell(_ view: FirstScreenView, index: Int) {
    doSelectPost(index: index)
  }

  func firstScreenViewDidTapRetryButton(_ view: FirstScreenView) {
    doLoadData()
  }
}
