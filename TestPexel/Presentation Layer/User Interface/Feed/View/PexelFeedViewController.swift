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
    
    var output: PexelFeedViewOutput!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
                
        let network = RESTService()
        
        let paginatorStateProvider = PexelFeedPaginator()
        
        let dataProvider = PexelFeedDataProviderPaginationDecorator(
            decoratee: PexelFeedDataProviderImpl(
                network: network,
                resourceFactory: PexelFeedResourceFactoryImpl()),
            paginator: paginatorStateProvider)
        
        let displayItemProvider = PexelFeedDisplayItemProviderImpl()
        
        let imageLoader = ImageLoaderImpl()
        
        let presenter = PexelFeedPresenter(
            dataProvider: dataProvider,
            displayItemProvider: displayItemProvider,
            imageLoader: imageLoader)
        
        displayItemProvider.imageLoaderDelegate = imageLoader
        paginatorStateProvider.delegate = presenter
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
        let displayModel = output.items[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: displayModel.cellType),
            for: indexPath
        )
        
        (cell as? AnyTableViewCell)?.setupAny(model: displayModel)
        
        return cell
    }
}
