//
//  PexelFeedViewController.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 28.09.2023.
//

import UIKit

import CustomNetworkService

final class PexelFeedViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    private let refreshControl = UIRefreshControl()

    var output: PexelFeedViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup(tableView: tableView)
        setup(pullToRefresh: refreshControl)
        
        output.onViewDidLoad()
    }
}

// MARK: - PexelFeedViewInput

extension PexelFeedViewController: PexelFeedViewInput {
    func didLoadItems() {
        DispatchQueue.main.async {[weak self] in
            if self?.refreshControl.isRefreshing == true { self?.refreshControl.endRefreshing() }
            
            self?.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource

extension PexelFeedViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { output.items.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let displayModel = output.items[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: displayModel.cellType),
            for: indexPath)
        
        (cell as? AnyTableViewCell)?.setupAny(model: displayModel)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension PexelFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedItem = output.items[indexPath.row]
        
        output.onSelected(item: selectedItem)
    }
}

// MARK: - IBAction

private extension PexelFeedViewController {
    @objc func refreshList(_ refreshControl: UIRefreshControl) {
        output.onRefreshList()
    }
}

// MARK: - Private

private extension PexelFeedViewController {
    func setup(tableView: UITableView) {
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func setup(pullToRefresh: UIRefreshControl) {
        pullToRefresh.addTarget(self, action: #selector(refreshList(_:)), for: .valueChanged)
        
        tableView.addSubview(pullToRefresh)
    }
}
