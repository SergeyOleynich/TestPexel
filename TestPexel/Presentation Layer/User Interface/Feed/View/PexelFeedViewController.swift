//
//  PexelFeedViewController.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 28.09.2023.
//

import UIKit

final class PexelFeedViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PexelFeedTableViewCell.self, forCellReuseIdentifier: String(describing: PexelFeedTableViewCell.self))
        tableView.register(PexelFeedLoadMoreTableViewCell.self, forCellReuseIdentifier: String(describing: PexelFeedLoadMoreTableViewCell.self))
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        return tableView
    }()
    
    private lazy var pullToRefresh: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshList(_:)), for: .valueChanged)
        
        return refreshControl
    }()

    var output: PexelFeedViewOutput!
    
    override func loadView() {
        let contentView = UIView()

        tableView.addSubview(pullToRefresh)
        contentView.addSubview(tableView)
        
        self.view = contentView
        
        setupConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.onViewDidLoad()
    }
}

// MARK: - PexelFeedViewInput

extension PexelFeedViewController: PexelFeedViewInput {
    func didLoadItems() {
        DispatchQueue.main.async {[weak self] in
            if self?.pullToRefresh.isRefreshing == true { self?.pullToRefresh.endRefreshing() }
            
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
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}
