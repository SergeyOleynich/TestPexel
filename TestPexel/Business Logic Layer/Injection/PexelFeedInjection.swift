//
//  PexelFeedInjection.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 02.10.2023.
//

import Foundation

import CustomNetworkService

protocol PexelFeedInjection {
    var networkService: NetworkService { get }
    var paginatorStateProvider: PexelFeedPaginator { get }
    var displayItemProvider: PexelFeedDisplayItemProvider { get }
    var imageLoader: ImageLoader { get }
    var resourceFactory: PexelFeedResourceFactory { get }
    var dataProvider: PexelFeedDataProvider { get }
}

struct PexelFeedInjectionImpl: PexelFeedInjection {
    let paginatorStateProvider: PexelFeedPaginator = PexelFeedPaginator()
    
    var displayItemProvider: PexelFeedDisplayItemProvider {
        PexelFeedDisplayItemProviderImpl()
    }
    
    var imageLoader: ImageLoader {
        CachedImageLoaderImpl(decoratee: ImageLoaderImpl())
    }
    
    var networkService: NetworkService {
        RESTService()
    }
    
    var resourceFactory: PexelFeedResourceFactory {
        PexelFeedResourceFactoryImpl()
    }
    
    var dataProvider: PexelFeedDataProvider {
        PexelFeedDataProviderPaginationDecorator(
            decoratee: PexelFeedDataProviderImpl(
                network: networkService,
                resourceFactory: resourceFactory),
            paginator: paginatorStateProvider)
    }
}
