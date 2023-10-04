//
//  PexelFeedInjection.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 02.10.2023.
//

import Foundation

import PNetworkService

protocol PexelFeedInjection {
    var pexelDetailFeedInjection: PexelDetailFeedInjection { get }
    var networkService: NetworkService { get }
    var paginatorStateProvider: PexelFeedPaginator { get }
    var displayItemProvider: PexelFeedDisplayItemProvider { get }
    var imageLoader: PexelFeedImageLoader { get }
    var resourceFactory: PexelFeedResourceFactory { get }
    var dataProvider: PexelFeedDataProvider { get }
}

struct PexelFeedInjectionImpl: PexelFeedInjection {
    let paginatorStateProvider: PexelFeedPaginator = PexelFeedPaginator()
    
    var pexelDetailFeedInjection: PexelDetailFeedInjection {
        PexelDetailFeedInjectionImpl()
    }
    
    var displayItemProvider: PexelFeedDisplayItemProvider {
        PexelFeedDisplayItemProviderImpl()
    }
    
    var imageLoader: PexelFeedImageLoader {
        PexelFeedImageLoaderImpl(
            decoratee: CachedImageLoaderImpl(
                decoratee: ImageLoaderImpl()))
    }
    
    var networkService: PNetworkService.NetworkService {
        PNetworkService.RootContainer(dependencies: self)
            .outputService
            .networkService
    }
    
    var resourceFactory: PexelFeedResourceFactory {
        PexelFeedResourceFactoryImpl(jsonDecoder: jsonDecoder)
    }
    
    var dataProvider: PexelFeedDataProvider {
        PexelFeedDataProviderPaginationDecorator(
            decoratee: PexelFeedDataProviderImpl(
                network: networkService,
                resourceFactory: resourceFactory),
            paginator: paginatorStateProvider)
    }
    
    private let jsonDecoder = JSONDecoder()
}

extension PexelFeedInjectionImpl: PNetworkService.Dependencies {
    var urlSession: URLSession? { .shared }
}

protocol PexelDetailFeedInjection {
    var imageLoader: ImageLoader { get }
}

struct PexelDetailFeedInjectionImpl: PexelDetailFeedInjection {
    var imageLoader: ImageLoader {
        CachedImageLoaderImpl(decoratee: ImageLoaderImpl())
    }
}
