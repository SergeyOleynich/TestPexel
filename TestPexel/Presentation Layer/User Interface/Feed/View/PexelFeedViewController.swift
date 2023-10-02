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
        
//        guard let feedMockUrl = Bundle.main.url(forResource: "FeedMock", withExtension: "txt") else { return }
//        guard let feedMockData = try? Data(contentsOf: feedMockUrl) else { return }
//
//        let configuration = URLSessionConfiguration.default
//        configuration.protocolClasses = [MockURLSessionProtocol.self]
//        MockURLSessionProtocol.mock(
//            for: URL(string: "https://api.pexels.com/v1/curated?per_page=10&page=1")!,
//            data: feedMockData,
//            response: HTTPURLResponse(
//                url: URL(string: "https://api.pexels.com/v1/curated?per_page=10&page=1")!,
//                statusCode: 200,
//                httpVersion: nil,
//                headerFields: nil),
//            error: nil)
        
//        let network = RESTService(session: URLSession(configuration: configuration))
        
        let network = RESTService()
        
        let paginatorStateProvider = PexelFeedPaginator()
        
        let dataProvider = PexelFeedDataProviderPaginationDecorator(
            decoratee: PexelFeedDataProviderImpl(
                network: network,
                resourceFactory: PexelFeedResourceFactoryImpl()),
            paginator: paginatorStateProvider)
        
        let presenter = PexelFeedPresenter(
            dataProvider: dataProvider,
            displayItemProvider: PexelFeedDisplayItemProviderImpl())
        
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
        
        if let cell = cell as? AnyTableViewCell {
            cell.setupAny(model: displayModel)
        }
        
        return cell
    }
}
