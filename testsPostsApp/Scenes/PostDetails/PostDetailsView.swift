//
//  PostDetailsView.swift
//  testsPostsApp
//
//  Created by Guillermo Asencio Sanchez on 24/3/21.
//

import UIKit

class PostDetailsView: UIView {

  // MARK: - Constants

  private struct ViewTraits {
    // Margins
    static let contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 18.0, right: 0.0)

    // Sizes
    static let loaderSize: CGFloat = 50.0
    static let estimatedHeaderHeight: CGFloat = 150.0
    static let estimatedRowHeight: CGFloat = 75.0
  }

  // MARK: - Properties

  private let tableView = UITableView(frame: .zero, style: .grouped)
  private let postView = PostDetailsHeaderView()

  private var tableCellData: [CommentTableViewCellData] = []

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

  func setupUI(data: PostDetailsViewData) {
    tableCellData = data.cellData
    postView.setupUI(data: data.headerData)
  }

  // MARK: - Private

  private func setupComponents() {
    backgroundColor = .customWhite

    tableView.dataSource = self
    tableView.delegate = self
    tableView.backgroundColor = nil
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = ViewTraits.estimatedRowHeight
    tableView.sectionHeaderHeight = UITableView.automaticDimension
    tableView.estimatedSectionHeaderHeight = ViewTraits.estimatedHeaderHeight
    tableView.separatorStyle = .none
    tableView.allowsSelection = false
    tableView.contentInset = ViewTraits.contentInset
    tableView.register(CommentTableViewCell.self,
                       forCellReuseIdentifier: CommentTableViewCell.reuseIdentifier)

    addSubviewForAutolayout(tableView)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: topAnchor),
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}

// MARK: - UITableViewDataSource

extension PostDetailsView: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    2
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return 0
    } else {
      return tableCellData.count
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let reuseId = CommentTableViewCell.reuseIdentifier
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)
    guard let commentCell = cell as? CommentTableViewCell else {
      return cell
    }
    commentCell.setupUI(data: tableCellData[indexPath.row])
    return commentCell
  }
}

// MARK: - UITableViewDelegate

extension PostDetailsView: UITableViewDelegate {

  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    UITableView.automaticDimension
  }

  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    if section == 0 {
      return postView
    } else {
      let headerView = SimpleTitleHeaderView()
      headerView.setupUI(text: "Comments (\(tableCellData.count))")
      return headerView
    }
  }
}
