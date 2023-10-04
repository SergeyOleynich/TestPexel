//
//  MockURLSessionProtocol.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 28.09.2023.
//

import Foundation

/// URLSession mock protocol
///
/// A special class which is needed when developer would like to mock URLSession
/// response with his custom response.
///
/// If internet connection is bad or server is not ready
///
///  ```
///  guard let mockUrl = /*Url to your local mock data file*/ else { return }
///  guard let mockData = try? Data(contentsOf: mockUrl) else { return }
///
///  let configuration = URLSessionConfiguration.default
///  configuration.protocolClasses = [MockURLSessionProtocol.self]
///
///  MockURLSessionProtocol.mock(
///     for: /*Your server side url*/,
///     data: mockData,
///     response: HTTPURLResponse(
///         url: /*Your server side url*/,
///         statusCode: 200,
///         httpVersion: nil,
///         headerFields: nil),
///     error: nil)
///
/// let urlSession = URLSession(configuration: configuration)
/// urlSession.dataTask(with: resource.urlRequest) { data, urlResponse, error in }.resume()
/// ```
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
