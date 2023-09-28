//
//  PexelFeedViewController.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 28.09.2023.
//

import UIKit
import CustomNetworkService

class MockURLSessionProtocol: URLProtocol {
    private static var mocks: [URL: MockURLSessionProtocol.Mock] = [:]
    
    private struct Mock {
        let data: Data?
        let response: URLResponse?
        let error: Error?
    }
    
    override class func canInit(with request: URLRequest) -> Bool {
        guard let requestUrl = request.url else { return false }
        
        return mocks[requestUrl] != nil
    }
    
    override class func canInit(with task: URLSessionTask) -> Bool { true }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }
    
    override func startLoading() {
        defer {
            client?.urlProtocolDidFinishLoading(self)
        }
        
        guard let requestUrl = request.url, let mock = Self.mocks[requestUrl] else { return }
        
        mock.data.flatMap { client?.urlProtocol(self, didLoad: $0)}
        mock.response.flatMap { client?.urlProtocol(self, didReceive: $0, cacheStoragePolicy: .notAllowed) }
        mock.error.flatMap { client?.urlProtocol(self, didFailWithError: $0 )}
    }
    
    override func stopLoading() {
        
    }
    
    static func mock(for url: URL, data: Data?, response: URLResponse?, error: Error?) {
        mocks[url] = MockURLSessionProtocol.Mock(data: data, response: response, error: error)
    }
}

final class PexelFeedViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLSessionProtocol.self]
        MockURLSessionProtocol.mock(
            for: URL(string: "https://api.pexels.com/v1/curated?per_page=1")!,
            data: "Test".data(using: .utf8),
            response: HTTPURLResponse(
                url: URL(string: "https://api.pexels.com/v1/curated?per_page=1")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil),
            error: nil)
        
        let network = RESTService(session: URLSession(configuration: configuration))
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
