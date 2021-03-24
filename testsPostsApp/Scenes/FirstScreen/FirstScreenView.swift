//
//  FirstScreenView.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 23/3/21.
//

import UIKit

protocol FirstScreenViewDelegate: class {
  func firstScreenViewDidTapCell(_ view: FirstScreenView, index: Int)
  func firstScreenViewDidTapRetryButton(_ view: FirstScreenView)
}

class FirstScreenView: UIView {

  // MARK: - Constants

  private struct ViewTraits {
    // Margins
    static let contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 18.0, right: 0.0)

    // Sizes
    static let loaderSize: CGFloat = 50.0
    static let estimatedRowHeight: CGFloat = 150.0
  }

  // MARK: - Properties

  weak var delegate: FirstScreenViewDelegate?

  private let tableView = UITableView(frame: .zero, style: .grouped)
  private let loaderView = LoaderView()
  private let screenLoadErrorView = ScreenLoadErrorView()

  private var tableCellData: [PostTableViewCellData] = []

  // MARK: - Lifecycle

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupComponents()
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Public

  func setState(state: FirstScreenViewState) {
    switch state {
    case .sucess(let data):
      screenLoadErrorView.isHidden = true
      loaderView.stopAnimating()
      loaderView.isHidden = true
      tableView.isHidden = false
      tableCellData = data
      tableView.reloadData()
    case .error:
      tableView.isHidden = true
      screenLoadErrorView.isHidden = false
      loaderView.stopAnimating()
      loaderView.isHidden = true
    case .loading:
      tableView.isHidden = true
      screenLoadErrorView.isHidden = true
      loaderView.isHidden = false
      loaderView.startAnimating()
    }
  }

  // MARK: - Private

  private func setupComponents() {
    backgroundColor = .customWhite

    tableView.dataSource = self
    tableView.delegate = self
    tableView.backgroundColor = nil
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = ViewTraits.estimatedRowHeight
    tableView.separatorStyle = .none
    tableView.contentInset = ViewTraits.contentInset
    tableView.allowsSelection = true
    tableView.register(PostTableViewCell.self,
                       forCellReuseIdentifier: PostTableViewCell.reuseIdentifier)

    screenLoadErrorView.isHidden = true
    screenLoadErrorView.delegate = self

    loaderView.isHidden = true

    addSubviewForAutolayout(tableView)
    addSubviewForAutolayout(screenLoadErrorView)
    addSubviewForAutolayout(loaderView)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),

      loaderView.heightAnchor.constraint(equalToConstant: ViewTraits.loaderSize),
      loaderView.widthAnchor.constraint(equalToConstant: ViewTraits.loaderSize),
      loaderView.centerXAnchor.constraint(equalTo: centerXAnchor),
      loaderView.centerYAnchor.constraint(equalTo: centerYAnchor),

      screenLoadErrorView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      screenLoadErrorView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      screenLoadErrorView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      screenLoadErrorView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}

// MARK: - ScreenLoadErrorViewDelegate

extension FirstScreenView: ScreenLoadErrorViewDelegate {

  func screenLoadErrorViewDidTapRetry(_ view: ScreenLoadErrorView) {
    delegate?.firstScreenViewDidTapRetryButton(self)
  }
}

// MARK: - UITableViewDataSource

extension FirstScreenView: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    tableCellData.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let reuseId = PostTableViewCell.reuseIdentifier
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)
    guard let postCell = cell as? PostTableViewCell else {
      return cell
    }
    postCell.setupUI(data: tableCellData[indexPath.row])
    return postCell
  }
}

// MARK: - UITableViewDelegate

extension FirstScreenView: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
    guard tableView.cellForRow(at: indexPath) as? PostTableViewCell != nil else {
      return
    }
    delegate?.firstScreenViewDidTapCell(self, index: indexPath.row)
  }
}
