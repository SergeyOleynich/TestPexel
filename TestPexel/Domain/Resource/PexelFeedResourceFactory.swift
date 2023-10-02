//
//  PexelFeedResourceFactory.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 01.10.2023.
//

import Foundation

import CustomNetworkService

protocol PexelFeedResourceFactory {
    var feedResource: ((Int) -> Resource<PexelFeedResponseItem>) { get }
}

struct PexelFeedResourceFactoryImpl: PexelFeedResourceFactory {
    var feedResource: ((Int) -> Resource<PexelFeedResponseItem>) {
        return { page in
            
            var urlComponent = URLComponents()
            urlComponent.queryItems = [
                URLQueryItem(name: "per_page", value: "10"),
                URLQueryItem(name: "page", value: "\(page)")
            ]
            urlComponent.scheme = "https"
            urlComponent.host = "api.pexels.com"
            urlComponent.path = "/v1/curated"
            
            var request = URLRequest(url: urlComponent.url!)
            request.setValue(
                "xefBfgNDNw1VlMjOFMRLvt8mfWhmnNQ1fUQrr1UIt3QFS2tBB083iHv3",
                forHTTPHeaderField: "Authorization")
            
            return Resource<PexelFeedResponseItem>(urlRequest: request)
        }
    }
}

