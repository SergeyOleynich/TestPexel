//
//  PexelFeedResourceFactory.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 01.10.2023.
//

import Foundation

import PNetworkService

protocol PexelFeedResourceFactory {
    var feedResource: ((Int) -> Resource<PexelFeedResponseItem>) { get }
}

struct PexelFeedResourceFactoryImpl: PexelFeedResourceFactory {
    private let jsonDecoder: JSONDecoder
    
    init(jsonDecoder: JSONDecoder) {
        self.jsonDecoder = jsonDecoder
    }
    
    var feedResource: ((Int) -> Resource<PexelFeedResponseItem>) {
        return { page in
            var urlComponent = URLComponents()
            urlComponent.queryItems = [
                URLQueryItem(name: "per_page", value: "10"),
                {
                    if page == 0 { return nil }
                    return URLQueryItem(name: "page", value: "\(page)")
                }()]
                .compactMap { $0 }
            
            urlComponent.scheme = "https"
            urlComponent.host = "api.pexels.com"
            urlComponent.path = "/v1/curated"
            
            var request = URLRequest(url: urlComponent.url!)
            
            if let apiKey = ProcessInfo.processInfo.environment["PEXEL_API_KEY"] {
                request.setValue(apiKey, forHTTPHeaderField: "Authorization")
            }
            
            return Resource<PexelFeedResponseItem>(
                urlRequest: request) { data -> Result<PexelFeedResponseItem, Error> in
                    Result { try self.jsonDecoder.decode(PexelFeedResponseItem.self, from: data) }
                }
        }
    }
}
