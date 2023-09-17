import Foundation
import UIKit
import EssentialFeed

public final class ListViewController: UIViewController, UITableViewDataSourcePrefetching, ResourceLoadingView, ResourceErrorView {
  private(set) public var errorView = ErrorView()
  
  public lazy var tableView: UITableView = {
    let tableView = UITableView(frame: view.frame, style: .plain)
    tableView.register(FeedImageCell.self, forCellReuseIdentifier: FeedImageCell.identifier)
    tableView.estimatedRowHeight = 580
    tableView.sectionHeaderHeight = 28.0
    tableView.sectionFooterHeight = 28.0
    tableView.insetsContentViewsToSafeArea = true
    return tableView
  }()
  
  private lazy var refreshControl: UIRefreshControl = {
    let refreshCtrl = UIRefreshControl()
    refreshCtrl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    return refreshCtrl
  }()
  
  private lazy var dataSource: UITableViewDiffableDataSource<Int, CellController> = {
    .init(tableView: tableView, cellProvider: { (tableView, index, controller) in
      controller.dataSource.tableView(tableView, cellForRowAt: index)
    })
  }()
  
  public var onRefresh: (() -> Void)?
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    
    view.addSubview(tableView)
    tableView.refreshControl = refreshControl
    //    view.addSubview(refreshControl)
        tableView.addSubview(refreshControl)
    configureTableView()
    refresh()
    NSLayoutConstraint.activate([
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      
//      refreshControl.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
//      refreshControl.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
    ])
  }
  
  private func configureTableView() {
    dataSource.defaultRowAnimation = .fade
    tableView.dataSource = dataSource
    tableView.tableHeaderView = errorView.makeContainer()
    
    errorView.onHide = { [weak self] in
      self?.tableView.beginUpdates()
      self?.tableView.sizeTableHeaderToFit()
      self?.tableView.endUpdates()
    }
  }
  
  public override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    tableView.sizeTableHeaderToFit()
  }
  
  public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    if previousTraitCollection?.preferredContentSizeCategory != traitCollection.preferredContentSizeCategory {
      tableView.reloadData()
    }
  }
  
  @objc private func refresh() {
    onRefresh?()
  }
  
  public func display(_ sections: [CellController]...) {
    var snapshot = NSDiffableDataSourceSnapshot<Int, CellController>()
    sections.enumerated().forEach { section, cellControllers in
      snapshot.appendSections([section])
      snapshot.appendItems(cellControllers, toSection: section)
    }
    
    if #available(iOS 15.0, *) {
      dataSource.applySnapshotUsingReloadData(snapshot)
    } else {
      dataSource.apply(snapshot)
    }
  }
  
  public func display(_ viewModel: ResourceLoadingViewModel) {
    refreshControl.update(isRefreshing: viewModel.isLoading)
  }
  
  public func display(_ viewModel: ResourceErrorViewModel) {
    errorView.message = viewModel.message
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let dl = cellController(at: indexPath)?.delegate
    dl?.tableView?(tableView, didSelectRowAt: indexPath)
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let dl = cellController(at: indexPath)?.delegate
    dl?.tableView?(tableView, willDisplay: cell, forRowAt: indexPath)
  }
  
  func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let dl = cellController(at: indexPath)?.delegate
    dl?.tableView?(tableView, didEndDisplaying: cell, forRowAt: indexPath)
  }
  
  public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    indexPaths.forEach { indexPath in
      let dsp = cellController(at: indexPath)?.dataSourcePrefetching
      dsp?.tableView(tableView, prefetchRowsAt: [indexPath])
    }
  }
  
  public func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
    indexPaths.forEach { indexPath in
      let dsp = cellController(at: indexPath)?.dataSourcePrefetching
      dsp?.tableView?(tableView, cancelPrefetchingForRowsAt: [indexPath])
    }
  }
  
  private func cellController(at indexPath: IndexPath) -> CellController? {
    dataSource.itemIdentifier(for: indexPath)
  }
}
