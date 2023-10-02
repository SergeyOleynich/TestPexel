//
//  MockURLSessionProtocol.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 28.09.2023.
//

import Foundation

/*
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
 */

public final class MockURLSessionProtocol: URLProtocol {
    private static var mocks: [URL: Mock] = [:]
    
    public override class func canInit(with request: URLRequest) -> Bool {
        guard let requestUrl = request.url else { return false }
        
        return mocks[requestUrl] != nil
    }
    
    public override class func canInit(with task: URLSessionTask) -> Bool { true }
    public override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }
    
    public override func startLoading() {
        defer {
            client?.urlProtocolDidFinishLoading(self)
        }
        
        guard let requestUrl = request.url, let mock = Self.mocks[requestUrl] else { return }
        
        mock.data.flatMap { client?.urlProtocol(self, didLoad: $0)}
        mock.response.flatMap { client?.urlProtocol(self, didReceive: $0, cacheStoragePolicy: .notAllowed) }
        mock.error.flatMap { client?.urlProtocol(self, didFailWithError: $0 )}
    }
    
    public override func stopLoading() { }
    
    public static func mock(for url: URL, data: Data?, response: URLResponse?, error: Error?) {
        mocks[url] = Mock(data: data, response: response, error: error)
    }
}

// MARK: - Mock

private struct Mock {
    let data: Data?
    let response: URLResponse?
    let error: Error?
}
