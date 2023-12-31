import Foundation
import UIKit
import EssentialFeed

public final class ListViewController<T: UITableViewCell>: UITableViewController, UITableViewDataSourcePrefetching, ResourceLoadingView, ResourceErrorView {
  private(set) public var errorView = ErrorView()
  
  
  private lazy var dataSource: UITableViewDiffableDataSource<Int, CellController> = {
    .init(tableView: tableView, cellProvider: { (tableView, index, controller) in
      controller.dataSource.tableView(tableView, cellForRowAt: index)
    })
  }()
  
  private lazy var refreshCtrl: UIRefreshControl = {
    let refresh = UIRefreshControl()
    refresh.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
    return refresh
  }()
  
  public var onRefresh: (() -> Void)?
  private let cell: T
  
  public init(_ cell: T) {
    self.cell = cell
    super.init(nibName: nil, bundle: nil)
  }
  
  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    
    tableView.register(cell: T.self)
    tableView.refreshControl = refreshCtrl
    tableView.tableFooterView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 414.0, height: 16.0)))
    tableView.sectionHeaderHeight = 28
    tableView.sectionFooterHeight = 28
    tableView.insetsContentViewsToSafeArea = true
    tableView.contentInset = .zero

    configureTableView()
    refresh()
  }
  
  private func configureTableView() {
    dataSource.defaultRowAnimation = .fade
    tableView.dataSource = dataSource
    tableView.prefetchDataSource = self
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
    refreshControl?.update(isRefreshing: viewModel.isLoading)
  }
  
  public func display(_ viewModel: ResourceErrorViewModel) {
    errorView.message = viewModel.message
  }
  
  public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(#line, #file.components(separatedBy: "/").last!, "tapped cell.")
    let dl = cellController(at: indexPath)?.delegate
    dl?.tableView?(tableView, didSelectRowAt: indexPath)
  }
  
  public override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let dl = cellController(at: indexPath)?.delegate
    dl?.tableView?(tableView, willDisplay: cell, forRowAt: indexPath)
  }
  
  public override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
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
