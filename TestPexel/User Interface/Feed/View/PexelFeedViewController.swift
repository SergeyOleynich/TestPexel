//
//  PexelFeedViewController.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 28.09.2023.
//

import UIKit

final class PexelFeedViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    
    var output: PexelFeedViewOutput!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let presenter = PexelFeedPresenter()
        presenter.viewInput = self
        output = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        
        output.onViewDidLoad()
    }
}

// MARK: -

extension PexelFeedViewController: PexelFeedViewInput {
    func didLoadItems() {
        DispatchQueue.main.async {[weak self] in
            self?.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource

extension PexelFeedViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { output.items.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: PexelFeedTableViewCell.self),
            for: indexPath
        ) as? PexelFeedTableViewCell else {
            preconditionFailure("Could not get cell")
        }
        
        cell.setup(with: output.items[indexPath.row])

        return cell
    }
}
