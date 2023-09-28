//
//  PexelFeedViewController.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 28.09.2023.
//

import UIKit
import CustomNetworkService

final class PexelFeedViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        
        let network = RESTService()
        var request = URLRequest(url: URL(string: "https://api.pexels.com/v1/curated?per_page=1")!)
        request.setValue("xefBfgNDNw1VlMjOFMRLvt8mfWhmnNQ1fUQrr1UIt3QFS2tBB083iHv3", forHTTPHeaderField: "Authorization")
        
        let resource = Resource<String>(urlRequest: request)
        network.request(resource: resource) { result in
            switch result {
            case .success(let success):
                print(success)
                
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension PexelFeedViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 10 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PexelFeedTableViewCell.self), for: indexPath) as? PexelFeedTableViewCell else {
            preconditionFailure("Could not get cell")
        }
        
        return cell
    }
}
