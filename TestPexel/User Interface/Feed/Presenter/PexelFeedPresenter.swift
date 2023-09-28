//
//  PexelFeedPresenter.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 28.09.2023.
//

import Foundation

import CustomNetworkService

final class PexelFeedPresenter {
    private var inputDataSource: [Int] = []
    
    weak var viewInput: PexelFeedViewInput?
}

// MARK: - PexelFeedViewOutput

extension PexelFeedPresenter: PexelFeedViewOutput {
    var items: [Int] { inputDataSource }
    
    func onViewDidLoad() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLSessionProtocol.self]
        MockURLSessionProtocol.mock(
            for: URL(string: "https://api.pexels.com/v1/curated?per_page=1")!,
            data: "[1, 2, 3, 4, 5]".data(using: .utf8),
            response: HTTPURLResponse(
                url: URL(string: "https://api.pexels.com/v1/curated?per_page=1")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil),
            error: nil)
        
        let network = RESTService(session: URLSession(configuration: configuration))
        var request = URLRequest(url: URL(string: "https://api.pexels.com/v1/curated?per_page=1")!)
        request.setValue("xefBfgNDNw1VlMjOFMRLvt8mfWhmnNQ1fUQrr1UIt3QFS2tBB083iHv3", forHTTPHeaderField: "Authorization")
        
        let resource = Resource<[Int]>(urlRequest: request)
        network.request(resource: resource) {[weak self] result in
            switch result {
            case .success(let success):
                self?.inputDataSource = success
                self?.viewInput?.didLoadItems()
                
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
