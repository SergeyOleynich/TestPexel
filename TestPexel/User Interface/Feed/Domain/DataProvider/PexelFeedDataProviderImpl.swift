//
//  PexelFeedDataProviderImpl.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 02.10.2023.
//

import Foundation

import CustomNetworkService

struct PexelFeedDataProviderImpl: PexelFeedDataProvider {
    private let network: NetworkService
    private let resourceFactory: PexelFeedResourceFactory
    
    init(network: NetworkService, resourceFactory: PexelFeedResourceFactory) {
        self.network = network
        self.resourceFactory = resourceFactory
    }
    
    func provideData(for page: Int, completion: @escaping ((Result<PexelFeedResponseItem, Error>) -> Void)) {
        network.request(resource: resourceFactory.feedResource(page), response: completion)
    }
}
