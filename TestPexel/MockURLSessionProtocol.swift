//
//  MockURLSessionProtocol.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 28.09.2023.
//

import Foundation

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
