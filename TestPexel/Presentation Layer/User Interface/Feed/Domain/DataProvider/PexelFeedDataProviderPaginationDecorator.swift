//
//  PexelFeedDataProviderPaginationDecorator.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 02.10.2023.
//

import Foundation

final class PexelFeedDataProviderPaginationDecorator: PexelFeedDataProvider {
    let decoratee: PexelFeedDataProvider
    let paginator: PexelFeedPaginator
    
    init(decoratee: PexelFeedDataProvider, paginator: PexelFeedPaginator) {
        self.decoratee = decoratee
        self.paginator = paginator
    }
    
    func provideData(for page: Int, completion: @escaping ((Result<PexelFeedResponseItem, Error>) -> Void)) {
        if page == 0 || paginator.state == .loadMore {
            print("start loading")
            paginator.apply(event: .didStartLoading)
            decoratee.provideData(for: page) {[weak self] response in
                switch response {
                case let .success(feedModel):
                    self?.paginator.apply(event:
                            .didFinishLoading(nextPage: feedModel.nextPage != nil ? page + 1 : nil))
                    completion(.success(feedModel))
                    
                case let .failure(failure):
                    completion(.failure(failure))
                }
            }
        }
    }
}
